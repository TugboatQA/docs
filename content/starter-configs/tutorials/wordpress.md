---
title: "WordPress"
date: 2019-09-19T11:00:57-04:00
weight: 4
---

Wondering how to configure Tugboat for a standard WordPress repository? Every site tends to have slightly different
requirements, so you may need to do more customizing, but this should get you started.

## First Things First

We'll provide 2 sets of instructions below for configuring your WordPress site to work with Tugboat:

- Where WordPress Core is committed at the root of your repo,
- and where WordPress is installed using Composer into a subdirectory.

When you copy the config file below, make sure you follow the instructions to adjust the config to your setup.

If you haven't yet, add a `.tugboat` directory to the root of your repo. This is where Tugboat will look for
configuration files and custom scripts.

## Configure WordPress For Tugboat

A standard WordPress configuration has a `wp-config.php` file at its root. Best practice is to not commit this file to
your repo as it contains sensitive information. If this file does exist, Tugboat will overwrite it with its own from the
default config, so here's what we recommend:

1. Add `wp-config.tugboat.php` to your `.tugboat` directory.
1. Add any specific config needed to your `.tugboat/wp-config.tugboat.php` file.
1. Set these values specifically:

```php
<?php
// Define Tugboat's database credentials.
define('DB_NAME', 'tugboat');
define('DB_USER', 'tugboat');
define('DB_PASSWORD', 'tugboat');
define('DB_HOST', 'mysql');

// Set our Tugboat hostname.
define( 'WP_HOME', 'https://' . getenv('TUGBOAT_SERVICE_URL_HOST') );

// Define the location where WordPress Core is installed.
// In this case, a subdirectory of the webroot called "wp".
define( 'WP_SITEURL', 'https://' . getenv('TUGBOAT_SERVICE_URL_HOST') . '/wp' );
```

_**Note:** Make sure your `wp-config.php` is formatted as close to the sample file as possible. The WordPress CLI gets
angry when it's not and will release the Kraken on your Tugboat builds._

## Configure Tugboat for WordPress

The Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in the git repository. Copy the code below into that file as a starting point. Then, you'll need
to tweak a few things for your particular installation.

For each service (php, mysql, etc) Tugboat runs three phases to build your preview:
[init, update, and build](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained).

### WordPress Starter Config

There are two starter configs provided here. Copy the appropriate one into `.tugboat/config.yml` and uncomment the
options that fit your setup.

#### A. Without Composer

```yaml
services:
  # Define our webserver service.
  php:
    # Use PHP 8.1 with Apache to serve the WordPress site.
    # This syntax pulls in the latest version of PHP 8.1.
    image: tugboatqa/php:8.1-apache

    # Set this as the default service. This does a few things:
    #   1. Clones the git repository into the service container,
    #   2. Exposes port 80 to the Tugboat HTTP proxy,
    #   3. Routes requests to the preview URL to this service.
    default: true

    # Wait until the mysql service is done building.
    depends: mysql

    # Configure the webserver.
    commands:
      # The INIT phase is for initializing the server itself.
      init:
        # Install prerequisite packages.
        - apt-get update
        - apt-get install -y rsync libzip-dev libmagickwand-dev

        # Turn on URL rewriting.
        - a2enmod expires headers rewrite

        # Install the PHP extensions.
        - docker-php-ext-install mysqli exif zip

        ## Install the WordPress CLI.
        - curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        - chmod +x wp-cli.phar
        - mv wp-cli.phar /usr/local/bin/wp

      # The UPDATE phase is for importing assets and dependencies.
      # When you refresh a Tugboat Preview, the process starts here, skipping `init`.
      update:
        ## @TODO: Define your site's docroot.
        #
        # OPTION 1: WordPress is at the repo root.
        # - ln -snf "${TUGBOAT_ROOT}" "${DOCROOT}"

        # OPTION 2: WordPress lives in a subdirectory (in this example, 'docroot').
        # - ln -snf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"

        ## @TODO: Include your custom WordPress config.
        #  This will depend on your setup.  Here our default WordPress config is looking
        #  in the DOCROOT for a file called `wp-config.local.php` so we'll move our
        #  Tugboat config files there.
        - cp ${TUGBOAT_ROOT}/.tugboat/wp-config.tugboat.php ${DOCROOT}/wp-config.local.php
        - cp ${TUGBOAT_ROOT}/.tugboat/.htaccess ${DOCROOT}/.htaccess

        ## @TODO: Import WordPress files (uploads).
        # Ensure the destination directory exists.
        - mkdir -p "${DOCROOT}/wp-content/uploads" || /bin/true

        # Add an SSH key to your source server if needed.  The Environment Variable
        # here can be added in the Tugboat Repository settings.
        # - echo "${MY_PRODUCTION_SSH_KEY}" > ~/.ssh/production_ssh_key
        # - chmod 600 ~/.ssh/production_ssh_key

        # OPTION 1: Import a tarball from a remote source.
        #  Periodically bundling your assets on production-like server and placing
        #  them somewhere Tugboat can access them can decrease build times and
        #  improve security.
        # - curl -O https://example.com/path/to/remote/source/uploads.tar.gz
        # - tar -C /tmp -zxf uploads.tar.gz
        # - rsync -avz --delete /tmp/uploads/ "${DOCROOT}/wp-content/uploads/"

        # OPTION 2: Manually sync files from a remote server.
        # Adjust the port value, user credentials, and path values as needed.
        # - rsync --archive --verbose --delete \
        #    -e "ssh -p 22 -o ConnectTimeout=120" \
        #    --exclude={'*.zip','*.gz', '*.tgz'} \
        #    example@example.com:/var/www/html/docroot/wp-content/uploads/ \
        #    "${DOCROOT}/wp-content/uploads"

        # After placing the files, fix file ownership and harden permissions.
        - chgrp -R www-data "${DOCROOT}/wp-content/uploads"
        - find "${DOCROOT}/wp-content/uploads" -type d -exec chmod 2775 {} \;
        - find "${DOCROOT}/wp-content/uploads" -type f -exec chmod 0664 {} \;

        # Cleanup.
        - apt-get clean
        - rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

      # Commands that build the site. When a Preview is built from a
      # Base Preview, the build workflow starts here, skipping the `init`
      # and `update` steps, because the results of those are inherited
      # from the base preview.
      build:
        # Flush WordPress Cache.
        - wp cache flush

  # Define the database server.
  # This name also acts as the hostname to access the service.
  mysql:
    # Use the latest available 5.x version of MySQL
    image: tugboatqa/mysql:5-debian

    # A set of commands to run while building this service
    commands:
      # Initialize and configure the database Server.
      init: []

      # Commands that import files, databases, or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        ## @TODO: Import a database.
        #
        # OPTION 1: Fetch a dump file from a remote source.
        #  Periodically running a database dump from a production-like environment
        #  to a place where Tugboat can access it can drastically reduce build times
        #  and the strain on the source server.  The public SSH key found in the
        #  Tugboat Repository configuration must be added to the external server
        #  in order to use scp.
        # - scp user@example.com:database.sql.gz /tmp/database.sql.gz
        # - zcat /tmp/database.sql.gz | mysql tugboat
        # - rm /tmp/database.sql.gz
        # OPTION 2: Sync the database directly from another environment with wp-cli.
        #  This is not the recommended option as you'll need to install wp-cli on this service
        #  in addition to the webserver, and it performs a database dump on each build, which
        #  can be time-consuming and expensive for big databases.
        # - curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        # - chmod +x wp-cli.phar
        # - mv wp-cli.phar /usr/local/bin/wp
        #  NOTE: This can be simplified by defining an alias for the source server in
        #  your `wp-cli.yml` file.
        # - wp --allow-root --ssh=example@www.example.com:22/var/www/html/docroot/wp  db export - > prod.sql
        # - wp --allow-root db import prod.sql
        # - rm prod.sql

      build: []
```

#### B. With Composer

```yaml
services:
  # Define our webserver service.
  php:
    # Use PHP 8.1 with Apache to serve the WordPress site.
    # This syntax pulls in the latest version of PHP 8.1.
    image: tugboatqa/php:8.1-apache

    # Set this as the default service. This does a few things:
    #   1. Clones the git repository into the service container,
    #   2. Exposes port 80 to the Tugboat HTTP proxy,
    #   3. Routes requests to the preview URL to this service.
    default: true

    # Wait until the mysql service is done building.
    depends: mysql

    # Configure the webserver.
    commands:
      # The INIT phase is for initializing the server itself.
      init:
        # Install prerequisite packages.
        - apt-get update
        - apt-get install -y rsync libzip-dev libmagickwand-dev

        # Turn on URL rewriting.
        - a2enmod expires headers rewrite

        # Install the PHP extensions.
        - docker-php-ext-install mysqli exif zip

      # The UPDATE phase is for importing assets and dependencies.
      # When you refresh a Tugboat Preview, the process starts here, skipping `init`.
      update:
        #  If you rarely modify your composer.json file, this line can be moved
        #  to the `init` phase to speed up refreshes and rebuilds that use base
        #  previews.
        - composer install --optimize-autoloader

        ## Install the WordPress CLI utility.
        #  Set up the wp-cli instance installed with composer to be used globally.
        - ln -snf "${TUGBOAT_ROOT}/vendor/bin/wp" /usr/local/bin

        ## @TODO: Define your site's docroot.
        #
        # OPTION 1: WordPress is at the repo root.
        # - ln -snf "${TUGBOAT_ROOT}" "${DOCROOT}"

        # OPTION 2: WordPress lives in a subdirectory (in this example, 'docroot').
        # - ln -snf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"

        ## @TODO: Include your custom WordPress config.
        #  This will depend on your setup.  Here our default WordPress config is looking
        #  in the DOCROOT for a file called `wp-config.local.php` so we'll move our
        #  Tugboat config files there.
        - cp ${TUGBOAT_ROOT}/.tugboat/wp-config.tugboat.php ${DOCROOT}/wp-config.local.php
        - cp ${TUGBOAT_ROOT}/.tugboat/.htaccess ${DOCROOT}/.htaccess

        ## @TODO: Import WordPress files (uploads).
        # Ensure the destination directory exists.
        - mkdir -p "${DOCROOT}/wp-content/uploads" || /bin/true

        # Add an SSH key to your source server if needed.  The Environment Variable
        # here can be added in the Tugboat Repository settings.
        # - echo "${MY_PRODUCTION_SSH_KEY}" > ~/.ssh/production_ssh_key
        # - chmod 600 ~/.ssh/production_ssh_key

        # OPTION 1: Import a tarball from a remote source.
        #  Periodically bundling your assets on production-like server and placing
        #  them somewhere Tugboat can access them can decrease build times and
        #  improve security.
        # - curl -O https://example.com/path/to/remote/source/uploads.tar.gz
        # - tar -C /tmp -zxf uploads.tar.gz
        # - rsync -avz --delete /tmp/uploads/ "${DOCROOT}/wp-content/uploads/"

        # OPTION 2: Manually sync files from a remote server.
        # Adjust the port value, user credentials, and path values as needed.
        # - rsync --archive --verbose --delete \
        #    -e "ssh -p 22 -o ConnectTimeout=120" \
        #    --exclude={'*.zip','*.gz', '*.tgz'} \
        #    example@example.com:/var/www/html/docroot/wp-content/uploads/ \
        #    "${DOCROOT}/wp-content/uploads"

        # After placing the files, fix file ownership and harden permissions.
        - chgrp -R www-data "${DOCROOT}/wp-content/uploads"
        - find "${DOCROOT}/wp-content/uploads" -type d -exec chmod 2775 {} \;
        - find "${DOCROOT}/wp-content/uploads" -type f -exec chmod 0664 {} \;

        # Cleanup.
        - apt-get clean
        - rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

      # Commands that build the site. When a Preview is built from a
      # Base Preview, the build workflow starts here, skipping the `init`
      # and `update` steps, because the results of those are inherited
      # from the base preview.
      build:
        # Flush WordPress Cache.
        - wp cache flush

  # Define the database server.
  # This name also acts as the hostname to access the service.
  mysql:
    # Use the latest available 5.x version of MySQL
    image: tugboatqa/mysql:5-debian

    # A set of commands to run while building this service
    commands:
      # Initialize and configure the database Server.
      init: []

      # Commands that import files, databases, or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        ## @TODO: Import a database.
        #
        # OPTION 1: Fetch a dump file from a remote source.
        #  Periodically running a database dump from a production-like environment
        #  to a place where Tugboat can access it can drastically reduce build times
        #  and the strain on the source server.  The public SSH key found in the
        #  Tugboat Repository configuration must be added to the external server
        #  in order to use scp.
        # - scp user@example.com:database.sql.gz /tmp/database.sql.gz
        # - zcat /tmp/database.sql.gz | mysql tugboat
        # - rm /tmp/database.sql.gz
        # OPTION 2: Sync the database directly from another environment with wp-cli.
        #  This is not the recommended option as you'll need to install wp-cli on this service
        #  in addition to the webserver, and it performs a database dump on each build, which
        #  can be time-consuming and expensive for big databases.
        # - curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        # - chmod +x wp-cli.phar
        # - mv wp-cli.phar /usr/local/bin/wp
        #  NOTE: This can be simplified by defining an alias for the source server in
        #  your `wp-cli.yml` file.
        # - wp --allow-root --ssh=example@www.example.com:22/var/www/html/docroot/wp  db export - > prod.sql
        # - wp --allow-root db import prod.sql
        # - rm prod.sql

      build: []
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
