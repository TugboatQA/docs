---
title: "Lagoon"
date: 2023-08-03T11:00:09-04:00
weight: 6
---

So you'd like to start testing your Lagoon-hosted website with Tugboat. While both systems are Docker based, they use
different architectures under the hood. This tutorial will help you configure your Lagoon project to talk to Tugboat,
and define your Tugboat configuration to read from Lagoon and build previews of your site.

## Configure Lagoon to Talk to Tugboat

### Steps

1. Find and copy for Tugboat SSH key
2. Add it to your SSH keys in Lagoon

### Details

1. Tugboat generates an SSH key for every repository you connect to it. After connecting your Lagoon repository, open
   the repository settings, find the SSH key, and copy it.

2. In your Lagoon UI, under your username in the menu, choose [Settings](https://dashboard.amazeeio.cloud/settings). Add
   a new SSH key for Tugboat and paste the value from the repository settings.

## Configure Tugboat to Pull From Lagoon

### Steps

1. Define your project and default environment
2. Create your `config.yml` file.

### 1. Set your project and environment

We'll configure Tugboat to pull a database, files, and anything else we need directly from Lagoon. First, choose the
Lagoon environment that you want to pull from. As close to production is best, but we don't recommend using the
production environment itself so Tugboat may make frequent requests which could slow the system down.

In your Tugboat Repository Settings, find the Environment Variables section. Here we'll define the project and
environment in Lagoon that we want to pull from.

1. Create a new environment variable and name it `LAGOON_PROJECT`.  Set the value to the name of the project. Ex. `demo-lullabot-drupalfull`
1. Create another new environment variable and name it `LAGOON_ENV`.  Set the value to the name of the environment you want to pull from. Ex. `main`
1. Create a third environment variable and name it `LAGOON_ENV_URL`.  Set the value to the full url of the environment you want to pull images from if using Stage File Proxy.  Ex. `https://nginx.main.demo-lullabot-drupalfull.us2.amazee.io` 

### 2. Create your config.yml

If you haven't already, create a directory called `.tugboat` at the root of your repository and place a file called
`config.yml` in it.

#### Webserver Personalization
In the `webserver` service, check the following sections and make sure they match your setup:

1. Check all file paths that are being created and linked.
2. Make sure your custom code is properly linked into the Drupal root.
3. Choose between downsyncing all your file assets or using Stage File Proxy.  (If you choose SFP, you can also comment out the line installing `lagoon-sync` on the `webserver` service.)

#### Database Personalization
Currently, Tugboat will create a database dump from the desired environment and sync it to Tugboat.  We don't have any personalization here until we can target pre-dumped files.

Copy this starter config into your `.tugboat/config.yml` file then make the necessary personalizations.

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
            - docker-php-ext-install opcache

            # Install Lagoon Sync so we can fetch the files.
            - DOWNLOAD_PATH=$(curl -sL "https://api.github.com/repos/uselagoon/lagoon-sync/releases/latest" | grep "browser_download_url" | cut -d \" -f 4 | grep linux_amd64) && wget -O /usr/local/bin/lagoon-sync $DOWNLOAD_PATH && chmod a+x /usr/local/bin/lagoon-sync

            # This may not be needed as lagoon-sync can handle getting assets from the Lagoon system.  This CLI allows us
            # to interact with the Lagoon environments for all sorts of other things.

            # Install the Lagoon CLI.
            #- curl -L "https://github.com/uselagoon/lagoon-cli/releases/download/v0.18.1/lagoon-cli-v0.18.1-linux-amd64" -o /usr/local/bin/lagoon
            #- chmod +x /usr/local/bin/lagoon

            # Create the ~/.lagoon.yml file, configure Lagoon, and authenticate.
            #- lagoon config add --force --lagoon "${LAGOON_PROJECT}" --graphql https://api.lagoon.amazeeio.cloud/graphql --hostname ssh.lagoon.amazeeio.cloud --port 32222 --ui https://dashboard.amazeeio.cloud
            #- lagoon config default --lagoon "${LAGOON_PROJECT}"
            #- lagoon login

         # The UPDATE phase is for importing assets and dependencies.
         update:
            # Create the necessary private directories outside the webroot. (see settings.tugboat.php)
            - mkdir -p "${TUGBOAT_ROOT}/files-private"
            - chgrp -R www-data "${TUGBOAT_ROOT}/files-private"
            - chmod -R 664 "${TUGBOAT_ROOT}/files-private"

            # Install/update packages managed by composer, including Drupal and Drush.
            - composer install --optimize-autoloader

            # Link the document root to the expected path. This example links /web
            # to the docroot.
            - ln -snf "${TUGBOAT_ROOT}/web" "${DOCROOT}"

            # Use the tugboat-specific Drupal settings.
            - ln -snf "${TUGBOAT_ROOT}/.tugboat/settings.tugboat.php" "${DOCROOT}/sites/default/settings.local.php"

            # Symlink your custom code into Drupal's installation.
            #- ln -snf "${TUGBOAT_ROOT}/custom/themes" "${DOCROOT}/themes/custom"
            #- ln -snf "${TUGBOAT_ROOT}/custom/modules" "${DOCROOT}/modules/custom"

            # Set public file permissions such that Drupal will not complain.
            # A translations folder is needed to enable Stage File Proxy.
            - mkdir -p "${DOCROOT}/sites/default/files/translations"
            - chgrp -R www-data "${DOCROOT}/sites/default/files"
            - find "${DOCROOT}/sites/default/files" -type d -exec chmod 2775 {} \;
            - find "${DOCROOT}/sites/default/files" -type f -exec chmod 0664 {} \;

            # Import files from Lagoon.
            # Due to Lagoon's config, we need to match the destination path to the source path.
            # Alternatively, you can comment this out and enable Stage File Proxy in the 'build' phase below.
            #- mkdir -p /app/web/sites/default/files
            #- ln -snf /app/web/sites/default/files "${DOCROOT}/sites/default/files"
            #- lagoon-sync sync files -e "${LAGOON_ENV}" --no-interaction

         # The BUILD phase is for running scripts to build and prepare your website.
         build:
            # Run the drush commands needed for a site with an imported database.
            - vendor/bin/drush cache:rebuild
            - vendor/bin/drush config:import -y
            - vendor/bin/drush updatedb -y
            - vendor/bin/drush cache:rebuild

            # File Sync Alternative: Enable Stage File Proxy.
            # This must be enabled after the config sync, otherwise Drupal will disable it when it runs the config sync.
            - vendor/bin/drush -r "${DOCROOT}" pm-enable --yes stage_file_proxy
            - vendor/bin/drush -r "${DOCROOT}" config:set stage_file_proxy.settings origin "${LAGOON_ENV_URL}"
            - vendor/bin/drush cache:rebuild

   # Define our database service.
   database:
      #image: uselagoon/mariadb-10.6-drupal:latest
      image: tugboatqa/mariadb:10.6

      # Checkout the codebase so we have access to the .lagoon.yml file to sync the DB.
      checkout: true

      # Run the commands to build out and install our database.
      commands:
         # The INIT phase initializes the server.
         init:
            # Set some helpful aliases for the cli and add the composer bin to the PATH.
            - echo "alias ll='ls -la'" >> /root/.bashrc

            # Increase the allowed packet size to 512MB.
            - mysql -e "SET GLOBAL max_allowed_packet=536870912;"

            # Ensure this packet size persists even if MySQL restarts.
            - echo "max_allowed_packet=536870912" >> /etc/mysql/conf.d/tugboat.cnf

            # Install Lagoon Sync so we can fetch a database.
            - DOWNLOAD_PATH=$(curl -sL "https://api.github.com/repos/uselagoon/lagoon-sync/releases/latest" | grep "browser_download_url" | cut -d \" -f 4 | grep linux_amd64) && wget -O /usr/local/bin/lagoon-sync $DOWNLOAD_PATH && chmod a+x /usr/local/bin/lagoon-sync

         # The UPDATE phase downloads and installs databases, assets, libraries, and dependencies.
         update:
            # Fetch the database from Lagoon and import it.
            # @TODO: Change this to rsync a pre-dumped file so we're not dumping the database on every build.
            - lagoon-sync sync mariadb -e "${LAGOON_ENV}" --skip-target-cleanup=true --skip-target-import=true --no-interaction
            - zcat /tmp/lagoon_sync_mariadb_*.sql.gz | mysql tugboat
            - rm /tmp/lagoon_sync_mariadb_*.sql.gz

      # Define our search engine.
      #solr:
      #image: uselagoon/solr-8-drupal:latest
      #image: tugboatqa/solr:8


      # Define our caching service.
      #redis:
      #image: uselagoon/redis-6:latest
      #image: tugboatqa/redis:6
```

Want to know more about something mentioned in the comments of this config file? Check out these topics:

- [Name your Service](/setting-up-services/how-to-set-up-services/name-your-service/)
- [Specify a Service image](/setting-up-services/how-to-set-up-services/specify-a-service-image/)
- [Leverage Service commands](/setting-up-services/how-to-set-up-services/leverage-service-commands/)
- [Define a default Service](/setting-up-services/how-to-set-up-services/define-a-default-service/)
- [Set the document root path](/setting-up-services/how-to-set-up-services/set-the-document-root-path/)
- [Set up remote SSH access](/setting-up-tugboat/select-repo-settings/#set-up-remote-ssh-access)
- [Preview build process phases (`init`, `update`, `build`)](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained)
- [How Base Previews work](/building-a-preview/preview-deep-dive/how-previews-work/#how-base-previews-work)

## Start Building Previews!

Once the Tugboat configuration file is committed to your git repository, you can start
[building previews](/building-a-preview/administer-previews/build-previews/)!
