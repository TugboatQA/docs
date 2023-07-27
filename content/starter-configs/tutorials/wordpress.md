---
title: "WordPress"
date: 2019-09-19T11:00:57-04:00
weight: 4
---

Wondering how to configure Tugboat for a standard WordPress repository? Every site tends to have slightly different
requirements, so you may need to do more customizing, but this should get you started.

## First Things First

We'll provide 2 sets of instructions below for configuring your WordPress site to work with Tugboat:

- One placing WordPress Core at the repo root,
- and one with WordPress Core in a subdirectory (recommended).

When you copy the config file below, make sure you follow the instructions to adjust the config to your setup.

If you haven't yet, add a `.tugboat` directory to the root of your repo. This is where Tugboat will look for
configuration files and custom scripts.

## Configure WordPress For Tugboat

A standard WordPress configuration has a `wp-config.php` file at its root. Best practice is to not commit this file to
your repo as it contains sensitive information. If this file does exist, Tugboat will overwrite it with its own from the
default config, so here's what we recommend:

1. Copy `wp-config-sample.php` from WordPress Core to `.tugboat/wp-config.tugboat.php`.
1. Copy any custom, non-sensitive config from your current `wp-config.php` file into your
   `.tugboat/wp-config.tugboat.php` file.
1. Replace the database credentials with these:

```php
<?php
define('DB_NAME', 'tugboat');
define('DB_USER', 'tugboat');
define('DB_PASSWORD', 'tugboat');
define('DB_HOST', 'mysql');
```

_**Note:** Make sure your `wp-config.php` is formatted as close to the sample file as possible. The WordPress CLI gets
angry when it's not and will release the Kraken on your Tugboat builds._

## Configure Tugboat for WordPress

The Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in the git repository. Copy the code below into that file as a starting point. Then, you'll need
to tweak a few things for your particular installation.

For each service (php, mysql, etc) Tugboat runs three phases to build your preview:
[init, update, and build](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained).

### Phase 1: INIT

In the INIT phase, Tugboat sets up your server and creates the docker containers for your services.

1. If you're using composer to install WordPress Core, uncomment that line in the `init` phase.
2. Just after that there are two options defined depending on your file structure. Uncomment the option that represents
   your setup.

### Phase 2: UPDATE

In the UPDATE phase, the server is ready, and you can now import any other assets your site needs, like images, a
database, etc.

1. If you're importing file assets, change the paths to match where you're importing them from.

### Phase 3: BUILD

In the BUILD phase, run any commands that your site needs to prepare itself to run.

1. Nothing to customize from this starter template.

### The `mysql` Service

At the bottom, in the `mysql` service, update the settings to fetch a database from a remote source and import it into
Tugboat.

### WordPress Starter Config

Copy this into `.tugboat/config.yml`

```yaml
services:
  # What to call the service hosting the site.
  php:
    # Use PHP 8.1 with Apache to serve the WordPress site; this syntax pulls in the latest version of PHP 8.1
    image: tugboatqa/php:8.1-apache

    # Set this as the default service. This does a few things
    #   1. Clones the git repository into the service container
    #   2. Exposes port 80 to the Tugboat HTTP proxy
    #   3. Routes requests to the preview URL to this service
    default: true

    # Wait until the mysql service is done building
    depends: mysql

    # A set of commands to run while building this service
    commands:
      # Commands that set up the basic preview infrastructure
      init:
        # Install prerequisite packages
        - apt-get update
        - apt-get install -y rsync libzip-dev

        # Turn on URL rewriting.
        - a2enmod rewrite headers

        # Install imagick
        - apt-get install -y libmagickwand-dev
        - pecl install imagick-beta -y
        - docker-php-ext-enable imagick

        # Install the PHP extensions
        - docker-php-ext-install mysqli exif zip

        # Install wp-cli
        - curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        - chmod +x wp-cli.phar
        - mv wp-cli.phar /usr/local/bin/wp

        # TODO: Uncomment this line if you're installing WordPress via composer.
        # - composer install --optimize-autoloader

        # TODO: Define your WordPress Core docroot.

        # OPTION 1: WordPress Core is at the repo root.
        # - ln -snf "${TUGBOAT_ROOT}" "${DOCROOT}"

        # OPTION 2: WordPress Core lives in a subdirectory (in this example, 'docroot').
        # - ln -snf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"

        # Set the wp-config.php file with the one you defined for Tugboat.
        - rm -rf ${DOCROOT}/wp-config.php
        - cp ${TUGBOAT_ROOT}/.tugboat/wp-config.tugboat.php ${DOCROOT}/wp-config.php

        # Update permalinks to remove the index.php.  These can't run until the database is imported.  How do we do that?
        - wp --allow-root --path="${DOCROOT}" option set permalink_structure /%postname%/
        - wp --allow-root --path="${DOCROOT}" rewrite flush --hard

      # Phase 2 (update): Import files, database, or any other assets that your
      # website needs to run.
      # When you refresh a Tugboat Preview, the process starts here, skipping `init`.
      update:
        # Copy the uploads directory from an external server. The public
        # SSH key found in the Tugboat Repository configuration must be
        # copied to the external server in order to use rsync over SSH.
        - mkdir -p "${DOCROOT}/wp-content/uploads" || /bin/true

        # TODO: Set the user credentials and path to where your remote files live.
        - rsync -avz --delete user@example.com:/path/to/wp-content/uploads/ "${DOCROOT}/wp-content/uploads/"
        - chgrp -R www-data "${DOCROOT}/wp-content/uploads"
        - find "${DOCROOT}/wp-content/uploads" -type d -exec chmod 2775 {} \;
        - find "${DOCROOT}/wp-content/uploads" -type f -exec chmod 0664 {} \;

        # Cleanup
        - apt-get clean
        - rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

      # Commands that build the site. When a Preview is built from a
      # Base Preview, the build workflow starts here, skipping the init
      # and update steps, because the results of those are inherited
      # from the base preview.
      build: |
        if [ "x${TUGBOAT_BASE_PREVIEW}" != "x" ]; then
            wp --allow-root --path="${DOCROOT}" search-replace "${TUGBOAT_BASE_PREVIEW_URL_HOST}" "${TUGBOAT_SERVICE_URL_HOST}" --skip-columns=guid
        else
            wp --allow-root --path="${DOCROOT}" search-replace 'WordPress.local' "${TUGBOAT_SERVICE_URL_HOST}" --skip-columns=guid
        fi

  # What to call the service hosting MySQL. This name also acts as the
  # hostname to access the service by from the php service.
  mysql:
    # Use the latest available 5.x version of MySQL
    image: tugboatqa/mysql:5-debian

    # A set of commands to run while building this service
    commands:
      # Commands that import files, databases, or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        # Copy a database dump from an external server. The public
        # SSH key found in the Tugboat Repository configuration must be
        # copied to the external server in order to use scp.
        # TODO: Set the user credentials and path to your remote database file.
        - scp user@example.com:database.sql.gz /tmp/database.sql.gz
        - zcat /tmp/database.sql.gz | mysql tugboat
        - rm /tmp/database.sql.gz
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
