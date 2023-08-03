---
title: "Lagoon"
date: 2023-08-03T11:00:09-04:00
weight: 6
---
So you'd like to start testing your Lagoon-hosted website with Tugboat.  While both systems are Docker based, they use different architectures under the hood.  This tutorial will help you configure your Lagoon project to talk to Tugboat, and define your Tugboat configuration to read from Lagoon and build previews of your site.

## Configure Lagoon to Talk to Tugboat
### Steps
1. Find and copy for Tugboat SSH key
2. Add it to your SSH keys in Lagoon

### Details
1. Tugboat generates an SSH key for every repository you connect to it.  After connecting your Lagoon repository, open the repository settings, find the SSH key, and copy it.

2. In your Lagoon UI, under your username in the menu, choose [Settings](https://dashboard.amazeeio.cloud/settings).  Add a new SSH key for Tugboat and paste the value from the repository settings.

## Configure Tugboat to Pull From Lagoon

### Steps
1. Define your project and default environment
2. Create your `config.yml` file.

### 1. Set your project and environment

We'll configure Tugboat to pull a database, files, and anything else we need directly from Lagoon.  First, choose the Lagoon environment that you want to pull from.  As close to production is best, but we don't recommend using the production environment itself so Tugboat may make frequent requests which could slow the system down.

In your Tugboat Repository Settings, find the Environment Variables section.  Here we'll define the project and environment in Lagoon that we want to pull from.

1. Create a new environment variable and name it `LAGOON_PROJECT`
2. Set the value to the name of the project.  Ex. `demo-lullabot-drupalfull`
3. Create another new environment variable and name it `LAGOON_ENV`
4. Set the value to the name of the environment you want to pull from.  Ex. `main`

### 2. Create your config.yml
If you haven't already, create a directory called `.tugboat` at the root of your repository and place a file called `config.yml` in it.

Copy this starter config into your `.tugboat/config.yml` file:

```yaml
# Because Tugboat does not run on Kubernetes, we'll need to run a different docker configuration.  We'll match our own
# docker images as closely as we can to Lagoon's, but we'll need to combine some services to get a similar result.
services:
  # Define our standard webserver.
  webserver:
    #image: uselagoon/php-8.1-cli-drupal:latest
    #image: uselagoon/nginx-drupal:latest
    #image: uselagoon/php-8.1-fpm:latest
    image: tugboatqa/php-nginx:8.1-fpm

    # Set this service as the default to handle HTTP requests.
    default: true

    # Ensure we have our database loaded first.
    depends: database

    # Run our phased commands to build the server and install the site.
    commands:
      # The INIT phase is for initializing the server itself.
      init:
        # Set some helpful aliases for the cli and add the composer bin to the PATH.
        - echo "alias ll='ls -la'" >> /root/.bashrc
        - echo "export PATH=$PATH:${TUGBOAT_ROOT}/vendor/bin" >> /root/.bashrc

        # Install opcache.
        # @TODO: Is this needed on FPM or if we're running REDIS?
        - docker-php-ext-install opcache

      # The UPDATE phase is for importing assets and dependencies.
      update:
        # Create the necessary private directories outside the webroot.
        - mkdir -p "${TUGBOAT_ROOT}/files-private" "${TUGBOAT_ROOT}/config"
        - chgrp -R www-data "${TUGBOAT_ROOT}/files-private"
        - chmod -R 664 "${TUGBOAT_ROOT}/files-private"

        # Install/update packages managed by composer, including drush.
        - composer install --optimize-autoloader

        # Link the document root to the expected path. This example links /web
        # to the docroot.
        - ln -snf "${TUGBOAT_ROOT}/web" "${DOCROOT}"

        # Use the tugboat-specific Drupal settings.
        - cp "${TUGBOAT_ROOT}/.tugboat/settings.tugboat.php" "${DOCROOT}/sites/default/settings.local.php"

        # Symlink your custom code into Drupal's installation.
        #- ln -snf "${TUGBOAT_ROOT}/custom/themes" "${DOCROOT}/themes/custom"
        #- ln -snf "${TUGBOAT_ROOT}/custom/modules" "${DOCROOT}/modules/custom"

        # Import files from a remote source.
        #- scp user@example.com:files.tgz /tmp/files.tgz
        #- tar -xvzf /tmp/files.tgz
        #- mv /tmp/files "${DOCROOT}/sites/default/"

        # Alternatively, import files from a tarball we added to the repo.
        - rm -rf "${DOCROOT}/sites/default/files"
        - tar -xvzf files.tgz
        - mv files "${DOCROOT}/sites/default/"

        # Another alternative: configure Stage File Proxy to link to a remote file source.
        # Ideally this would be done in your settings.tugboat.php file.

        # Set file permissions such that Drupal will not complain.
        - mkdir -p "${DOCROOT}/sites/default/files"
        - chgrp -R www-data "${DOCROOT}/sites/default/files"
        - find "${DOCROOT}/sites/default/files" -type d -exec chmod 2775 {} \;
        - find "${DOCROOT}/sites/default/files" -type f -exec chmod 0664 {} \;

      # The BUILD phase is for running scripts to build and prepare your website.
      build:
        # Run the drush commands needed for a site with an imported database.
        - vendor/bin/drush cache:rebuild
        - vendor/bin/drush config:import -y
        - vendor/bin/drush updatedb -y
        - vendor/bin/drush cache:rebuild


  # Define our database.
  database:
    #image: uselagoon/mariadb-10.6-drupal:latest
    image: tugboatqa/mariadb:10.6

    # Checkout the codebase so we have access to the database dump file we added for the demo.
    checkout: true

    # Run the commands to build out and install our database.
    commands:
      # The INIT phase initializes the server.
      init:
        # Increase the allowed packet size to 512MB.
        - mysql -e "SET GLOBAL max_allowed_packet=536870912;"

        # Ensure this packet size persists even if MySQL restarts.
        - echo "max_allowed_packet=536870912" >> /etc/mysql/conf.d/tugboat.cnf

        # Install the Lagoon CLI.
        - curl -L "https://github.com/uselagoon/lagoon-cli/releases/download/v0.18.1/lagoon-cli-v0.18.1-linux-amd64" -o /usr/local/bin/lagoon
        - chmod +x /usr/local/bin/lagoon

        # Create the ~/.lagoon.yml file, configure Lagoon, and authenticate.
        - lagoon config add --force --lagoon "${LAGOON_PROJECT_NAME}" --graphql https://api.lagoon.amazeeio.cloud/graphql --hostname ssh.lagoon.amazeeio.cloud --port 32222 --ui https://dashboard.amazeeio.cloud
        - lagoon config default --lagoon "${LAGOON_PROJECT_NAME}"
        - lagoon login

        # Install Lagoon Sync so we can fetch a database.
        - DOWNLOAD_PATH=$(curl -sL "https://api.github.com/repos/uselagoon/lagoon-sync/releases/latest" | grep "browser_download_url" | cut -d \" -f 4 | grep linux_amd64) && wget -O /usr/local/bin/lagoon-sync $DOWNLOAD_PATH && chmod a+x /usr/local/bin/lagoon-sync
        - lagoon-sync sync mariadb -e "${LAGOON_PROD_ENV}" --no-interaction

      # The UPDATE phase downloads and installs and assets, libraries, and dependencies.
      update:
        # Fetch a remote database and install it.
        #- scp user@example.com:database.sql.gz /tmp/database.sql.gz
        #- zcat /tmp/database.sql.gz | mysql tugboat
        #- rm /tmp/database.sql.gz

        # Alternatively, use a dummy database from this repo.
        - zcat ${TUGBOAT_ROOT}/sqldump.sql.gz | mysql tugboat

  # Define our search engine.
  solr:
    #image: uselagoon/solr-8-drupal:latest
    image: tugboatqa/solr:8


  # Define our caching service.
  redis:
    #image: uselagoon/redis-6:latest
    image: tugboatqa/redis:6
```
