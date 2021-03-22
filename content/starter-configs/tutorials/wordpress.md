---
title: "Wordpress"
date: 2019-09-19T11:00:57-04:00
weight: 4
---

Wondering how to configure Tugboat for a standard WordPress repository? Every site tends to have slightly different
requirements, so you may need to do more customizing, but this should get you started.

## Configure WordPress

For WordPress to use environment-specific settings, you'll need to make some changes to `wp-config.php`. One way to do
this is to commit a "default" version of the file to the git repository, and include a "local" config file with override
options. That local file should not be included in the git repository.

These are the settings we are particularly interested in for Tugboat, but the the concept could be extended to cover the
remaining settings in `wp-config.php`:

```php
if ( file_exists( dirname( __FILE__ ) . '/wp-config.local.php' ) )
    include(dirname(__FILE__) . '/wp-config.local.php');

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
if ( !defined('DB_NAME') )
    define('DB_NAME', 'database_name_here');

/** MySQL database username */
if ( !defined('DB_USER') )
    define('DB_USER', 'username_here');

/** MySQL database password */
if ( !defined('DB_PASSWORD') )
    define('DB_PASSWORD', 'password_here');

/** MySQL hostname */
if ( !defined('DB_HOST') )
    define('DB_HOST', 'localhost');
```

Add a file to the git repository at `.tugboat/wp-config.local.php` with the following contents:

```php
<?php
define('DB_NAME', 'tugboat');
define('DB_USER', 'tugboat');
define('DB_PASSWORD', 'tugboat');
define('DB_HOST', 'mysql');
```

## Configure Tugboat

The Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
.tugboat/config.yml in the git repository. Here's a basic WordPress configuration you can use as a starting point, with
comments to explain what's going on:

```yaml
services:
  # What to call the service hosting the site.
  php:
    # Use PHP 7.x with Apache to serve the WordPress site; this syntax pulls in the latest version of PHP 7
    image: tugboatqa/php:7-apache

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
        - apt-get install -y rsync

        # Install the PHP mysqli extension
        - docker-php-ext-install mysqli

        # Install wp-cli
        - curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        - chmod +x wp-cli.phar
        - mv wp-cli.phar /usr/local/bin/wp

        # Use the tugboat-specific wp-config.local.php
        - cp "${TUGBOAT_ROOT}/.tugboat/wp-config.local.php" "${DOCROOT}/"

        # Link the document root to the expected path. This example links /web
        # to the docroot
        - ln -snf "${TUGBOAT_ROOT}/web" "${DOCROOT}"

      # Commands that import files, databases, or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        # Copy the uploads directory from an external server. The public
        # SSH key found in the Tugboat Repository configuration must be
        # copied to the external server in order to use rsync over SSH.
        - mkdir -p "${DOCROOT}/wp-content/uploads" || /bin/true
        - rsync -av --delete user@example.com:/path/to/wp-content/uploads/ "${DOCROOT}/wp-content/uploads/"
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
            wp --allow-root --path="${DOCROOT}" search-replace 'wordpress.local' "${TUGBOAT_SERVICE_URL_HOST}" --skip-columns=guid
        fi

  # What to call the service hosting MySQL. This name also acts as the
  # hostname to access the service by from the php service.
  mysql:
    # Use the latest available 5.x version of MySQL
    image: tugboatqa/mysql:5

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
