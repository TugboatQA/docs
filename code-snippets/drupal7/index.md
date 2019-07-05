# Drupal 7

Wondering how to configure Tugboat for a typical Drupal 7 repository? Every
Drupal site tends to have slightly different requirements, so you may need to do
more customizing, but this should get you started.

## Configure Drupal

A common practice for managing Drupal's `settings.php` is to remove sensitive
information, such as database credentials, before committing it to git. Then,
the sensitive information is loaded from a `settings.local.php` file that exists
only on the Drupal installation location.

This pattern works very well with Tugboat. It lets you keep a Tugboat-specific
set of configurations in your repository where it can be copied in during the
[Preview build process](../../building-a-preview/index.md#the-build-process-explained).

Add the following to the end of `settings.php`:

```php
if (file_exists(DRUPAL_ROOT . '/' . conf_path() . '/settings.local.php')) {
  include DRUPAL_ROOT . '/' . conf_path() . '/settings.local.php';
}
```

Add a file to the git repository at `.tugboat/settings.local.php` with the
following content:

```php
<?php
$databases = array (
  'default' =>
  array (
    'default' =>
    array (
      'database' => 'tugboat',
      'username' => 'tugboat',
      'password' => 'tugboat',
      'host' => 'mysql',
      'port' => '',
      'driver' => 'mysql',
      'prefix' => '',
    ),
  ),
);
```

## Configure Tugboat

The Tugboat configuration is managed by a
[YAML file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file) at
`.tugboat/config.yml` in the git repository. Here's a basic Drupal 7
configuration you can use as a starting point, with comments to explain what's
going on:

```yaml
services:
  php:
    # Use PHP 7.1 with Apache to serve the Drupal site
    image: tugboatqa/php:7.1-apache

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
        # Install opcache and enable mod-rewrite.
        - docker-php-ext-install opcache
        - a2enmod headers rewrite

        # Install drush 8.1.17
        - composer --no-ansi global require drush/drush:8.1.17
        - ln -sf ~/.composer/vendor/bin/drush /usr/local/bin/drush

        # Link the document root to the expected path. This example links
        # /docroot to the docroot
        - ln -snf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"

      # Commands that import files, databases,  or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        # Use the tugboat-specific Drupal settings
        - cp "${TUGBOAT_ROOT}/.tugboat/settings.local.php"
          "${DOCROOT}/sites/default/"

        # Copy the files directory from an external server. The public
        # SSH key found in the Tugboat Repository configuration must be
        # copied to the external server in order to use rsync over SSH.
        - rsync -av --delete user@example.com:/path/to/files/
          "${DOCROOT}/sites/default/files/"
        - chgrp -R www-data "${DOCROOT}/sites/default/files"
        - find "${DOCROOT}/sites/default/files" -type d -exec chmod 2775 {} \;
        - find "${DOCROOT}/sites/default/files" -type f -exec chmod 0664 {} \;

        # Alternatively, another common practice is to use the
        # stage_file_proxy Drupal module. This module lets Drupal serve
        # files from another publicly-accessible Drupal site instead of
        # syncing the entire files directory into the Tugboat Preview.
        # This results in smaller previews and reduces the build time.
        - drush -r "${DOCROOT}" pm-download stage_file_proxy
        - drush -r "${DOCROOT}" pm-enable --yes stage_file_proxy
        - drush -r "${DOCROOT}" variable-set stage_file_proxy_origin
          "http://www.example.com"

      # Commands that build the site. This is where you would add things
      # like feature reverts or any other drush commands required to
      # set up or configure the site. When a preview is built from a
      # base preview, the build workflow starts here, skipping the init
      # and update steps, because the results of those are inherited
      # from the base preview.
      build:
        - drush -r "${DOCROOT}" cache-clear all
        - drush -r "${DOCROOT}" updb -y

  # What to call the service hosting MySQL. This name also acts as the
  # hostname to access the service by from the php service.
  mysql:
    # Use the latest available 5.x version of MySQL
    image: tugboatqa/mysql:5

    # A set of commands to run while building this service
    commands:
      # Commands that import files, databases,  or other assets. When an
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

## Start Building Previews!

Once the Tugboat configuration file is committed to your git repository, you can
start [building previews](../../building-a-preview/index.md)!
