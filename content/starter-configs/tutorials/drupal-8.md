---
title: "Drupal 8"
date: 2019-09-19T10:59:21-04:00
weight: 2
---

Wondering how to configure Tugboat for a typical Drupal 8 repository? Every Drupal site tends to have slightly different
requirements, so you may need to do more customizing, but this should get you started.

## Configure Drupal

A common practice for managing Drupal's `settings.php` is to leave sensitive information, such as database credentials,
out of it and commit it to git. Then, the sensitive information is loaded from a `settings.local.php` file that exists
only on the Drupal installation location.

This pattern works very well with Tugboat. It lets you keep a Tugboat-specific set of configurations in your repository,
where you can copy it into place with a
[configuration file command](/setting-up-services/how-to-set-up-services/leverage-service-commands/).

Add or uncomment the following at the end of `settings.php`

```php
if (file_exists($app_root . '/' . $site_path . '/settings.local.php')) {
  include $app_root . '/' . $site_path . '/settings.local.php';
}
```

Add a file to the git repository at `.tugboat/settings.local.php` with the following content:

```php
<?php
$databases['default']['default'] = array (
  'database' => 'tugboat',
  'username' => 'tugboat',
  'password' => 'tugboat',
  'prefix' => '',
  'host' => 'mysql',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);
// Use the TUGBOAT_REPO_ID to generate a hash salt for Tugboat sites.
$settings['hash_salt'] = hash('sha256', getenv('TUGBOAT_REPO_ID'));
```

## Configure Tugboat

The Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in the git repository. Here's a basic Drupal 8 configuration you can use as a starting point, with
comments to explain what's going on:

```yaml
services:
  # What to call the service hosting the site.
  php:
    # Use PHP 7.x with Apache; this syntax pulls in the latest version of PHP 7
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
        # Install opcache and mod-rewrite.
        - docker-php-ext-install opcache
        - a2enmod headers rewrite

        # Install drush-launcher, if desired.
        - wget -O /usr/local/bin/drush https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar
        - chmod +x /usr/local/bin/drush

        # Link the document root to the expected path. This example links /web
        # to the docroot.
        - ln -snf "${TUGBOAT_ROOT}/web" "${DOCROOT}"

        # A common practice in many Drupal projects is to store the config and
        # private files outside of the Drupal root. If that's the case for your
        # project, you can either specify the absolute paths to those
        # directories in your settings.local.php, or you can symlink them in
        # here. Here is an example of the latter option:
        - ln -snf "${TUGBOAT_ROOT}/config" "${DOCROOT}/../config"
        - ln -snf "${TUGBOAT_ROOT}/files-private" "${DOCROOT}/../files-private"

      # Commands that import files, databases,  or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        # Use the tugboat-specific Drupal settings.
        - cp "${TUGBOAT_ROOT}/.tugboat/settings.local.php" "${DOCROOT}/sites/default/"

        # Install/update packages managed by composer, including drush.
        - composer install --optimize-autoloader

        # Copy Drupal's public files directory from an external server. The
        # public SSH key found in the Tugboat Repository configuration must be
        # copied to the external server in order to use rsync over SSH.
        - rsync -av --delete user@example.com:/path/to/files/ "${DOCROOT}/sites/default/files/"

        # Alternatively, another common practice is to use the
        # stage_file_proxy Drupal module. This module lets Drupal serve
        # files from another publicly-accessible Drupal site instead of
        # syncing the entire files directory into the Tugboat Preview.
        # This results in smaller previews and reduces the build time.
        - composer require --dev drupal/stage_file_proxy
        - drush pm:enable --yes stage_file_proxy
        - drush config:set --yes stage_file_proxy.settings origin "http://www.example.com"

        # Set file permissions such that Drupal will not complain
        - chgrp -R www-data "${DOCROOT}/sites/default/files"
        - find "${DOCROOT}/sites/default/files" -type d -exec chmod 2775 {} \;
        - find "${DOCROOT}/sites/default/files" -type f -exec chmod 0664 {} \;

      # Commands that build the site. This is where you would add things
      # like feature reverts or any other drush commands required to
      # set up or configure the site. When a preview is built from a
      # base preview, the build workflow starts here, skipping the init
      # and update steps, because the results of those are inherited
      # from the base preview.
      build:
        - composer install --optimize-autoloader
        - drush cache:rebuild
        - drush config:import -y
        - drush updatedb -y
        - drush cache:rebuild

  # What to call the service hosting MySQL. This name also acts as the
  # hostname to access the service by from the php service.
  mysql:
    # Use the latest available 5.x version of MySQL
    image: tugboatqa/mysql:5-debian

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

Want to know more about something mentioned in the comments of this config file? Check out these topics:

- [Name your Service](/setting-up-services/how-to-set-up-services/name-your-service/)
- [Specify a Service image](/setting-up-services/how-to-set-up-services/specify-a-service-image/)
- [Leverage Service commands](/setting-up-services/how-to-set-up-services/leverage-service-commands/)
- [Define a default Service](/setting-up-services/how-to-set-up-services/define-a-default-service/)
- [Set the document root path](/setting-up-services/how-to-set-up-services/set-the-document-root-path/)
- [Set up remote SSH access](/setting-up-tugboat/select-repo-settings/#set-up-remote-ssh-access)
- [Preview build process phases (`init`, `update`, `build`)](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained)
- [How Base Previews work](/building-a-preview/preview-deep-dive/how-previews-work/#how-base-previews-work)
- [Multisite with Tugboat](https://www.tugboatqa.com/blog/multisite-with-tugboat)

## Start Building Previews!

Once the Tugboat configuration file is committed to your git repository, you can start
[building previews](/building-a-preview/administer-previews/build-previews/)!
