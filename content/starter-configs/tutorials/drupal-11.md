---
title: "Drupal 11"
date: 2025-01-12T11:14:19-04:00
weight: 1
---

Wondering how to configure Tugboat for a typical Drupal 11 repository? Every Drupal site tends to have slightly
different requirements, so you may need to do more customizing, but this should get you started.

The following documentation assumes you are using Composer to manage your Drupal 11 project (typically with either the
`drupal/recommended-project` or the `drupal-composer/drupal-project` projects).

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
/**
 * @file
 * Tugboat preview environment settings.
 *
 * To activate these settings for sites in Tugboat preview environments,
 * ensure that this file is placed in .tugboat/settings.local.php
 * in the root of your git repository.
 */

/**
 * Database connection information for Tugboat preview environments.
 */
$databases['default']['default'] = array (
  'database' => 'tugboat',
  'username' => 'tugboat',
  'password' => 'tugboat',
  'prefix' => '',
  'host' => 'database',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
  'isolation_level' => "READ COMMITTED",
);

/**
 * Salt for one-time login links, cancel links, form tokens, etc.
 *
 * Use the TUGBOAT_REPO_ID to generate a hash salt for Tugboat sites.
 */
$settings['hash_salt'] = hash('sha256', getenv('TUGBOAT_REPO_ID'));

/**
 * Location of config sync directory in Tugboat preview environment.
 *
 * If your Drupal config sync directory is outside of the Drupal web root,
 * uncomment and adapt the following setting.
 *
 * Note: the TUGBOAT_ROOT environment variable is equivalent to the git repo
 * root.
 */
$settings['config_sync_directory'] = getenv('TUGBOAT_ROOT') . '/config';

/**
 * Location of private file path in Tugboat preview environment.
 *
 * If you are using private files, and that directory is outside of the Drupal
 * web root, uncomment and adapt the following.
 *
 * Note: the TUGBOAT_ROOT environment variable is equivalent to the git repo
 * root.
 */
# $settings['file_private_path'] = getenv('TUGBOAT_ROOT') . '/files-private';

/**
 * Skip file system permissions hardening.
 *
 * The system module will periodically check the permissions of your site's
 * site directory to ensure that it is not writable by the website user. For
 * sites that are managed with a version control system, this can cause problems
 * when files in that directory such as settings.php are updated, because the
 * user pulling in the changes won't have permissions to modify files in the
 * directory.
 */
$settings['skip_permissions_hardening'] = TRUE;

/**
 * Trusted host configuration for Tugboat preview environments.
 *
 * Drupal requires you to specify which hostnames are allowed to access your
 * site. Since Tugboat preview URLs use the tugboatqa.com domain, we add this
 * pattern to allow Drupal to accept requests from any Tugboat preview URL.
 *
 * @see https://www.drupal.org/docs/installing-drupal/trusted-host-settings
 */
$settings['trusted_host_patterns'] = [
  '\.tugboatqa\.com$',
];

/**
 * Set the memory limit for the CLI (drush).
 */
if (PHP_SAPI === 'cli') {
  ini_set('memory_limit', '-1');
}
```

## Configure Tugboat

The Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in the git repository. Here's a basic Drupal 11 configuration you can use as a starting point,
with comments to explain what's going on:

```yaml
# Tugboat configuration for Drupal 11
# https://docs.tugboatqa.com/starter-configs/tutorials/drupal-11/

services:
  # Define the database service.
  database:
    # Drupal 11 requires MariaDB 10.6+ or MySQL 8.0+
    # Use MariaDB 10.11 for best compatibility
    image: tugboatqa/mariadb:10.11

    # A set of commands to run while building this service
    commands:
      # Configure the server for the site to run on.
      init:
        # Increase the allowed packet size to 512MB.
        - mysql -e "SET GLOBAL max_allowed_packet=536870912;"
        # Ensure this packet size persists even if MySQL restarts.
        - echo "max_allowed_packet=536870912" >> /etc/mysql/conf.d/tugboat.cnf

      # Commands that import files, databases, or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        # TODO: Copy a database dump from an external server. The public
        # SSH key found in the Tugboat Repository configuration must be
        # copied to the external server in order to use scp.
        - scp user@example.com:database.sql.gz /tmp/database.sql.gz
        - zcat /tmp/database.sql.gz | mysql -h database -u tugboat -ptugboat tugboat
        - rm /tmp/database.sql.gz

      # Run any commands needed to prepare the site. This is generally not needed
      # for database services.
      build: []

  # Define the webserver service.
  webserver:
    # Drupal 11 requires PHP 8.3 as the minimum version.
    # This is updated from PHP 8.1 used in the Drupal 10 tutorial.
    image: tugboatqa/php:8.3-apache

    # Set this as the default service. This does a few things
    #   1. Clones the git repository into the service container
    #   2. Exposes port 80 to the Tugboat HTTP proxy
    #   3. Routes requests to the preview URL to this service
    default: true

    # Wait until the mysql service is done building.
    depends: database

    # A set of commands to run while building this service
    commands:
      # The INIT command configures the webserver.
      init:
        # Install opcache and mod-rewrite.
        - docker-php-ext-install opcache
        - a2enmod headers rewrite

        # Increase PHP memory limit to 512MB for Drupal operations.
        # Drupal 11 installation and updates can be memory-intensive.
        - echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/tugboat.ini

        # Link the document root to the expected path. This example links /web
        # to the docroot (standard for composer-based Drupal projects).
        - ln -snf "${TUGBOAT_ROOT}/web" "${DOCROOT}"

        # Create any required directories that don't exist.
        # Uncomment if using private files outside the webroot:
        # - mkdir -p "${TUGBOAT_ROOT}/files-private"

      # Commands that import files, databases, or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        # Install/update packages managed by composer.
        - composer install --optimize-autoloader

        # Set the tugboat-specific Drupal settings.
        - cp "${TUGBOAT_ROOT}/.tugboat/settings.local.php" "${DOCROOT}/sites/default/settings.local.php"

        # Map your custom modules and themes into the Drupal structure.
        # Uncomment and adapt these if your repository has custom code outside
        # the standard Drupal directory structure:
        # - ln -snf "${TUGBOAT_ROOT}/custom/themes" "${DOCROOT}/themes/custom"
        # - ln -snf "${TUGBOAT_ROOT}/custom/modules" "${DOCROOT}/modules/custom"

        # Make sure our files and translations folders exist and are writable.
        - mkdir -p "${DOCROOT}/sites/default/files/translations"
        - chgrp -R www-data "${DOCROOT}/sites/default/files"
        - find "${DOCROOT}/sites/default/files" -type d -exec chmod 2775 {} \;
        - find "${DOCROOT}/sites/default/files" -type f -exec chmod 0664 {} \;

        # Optional: Copy Drupal's public files directory from an external server.
        # The public SSH key found in the Tugboat Repository configuration must be
        # copied to the external server in order to use rsync over SSH. More commonly
        # we use Stage File Proxy, which we enable in the `build` step below.
        # - rsync -av --delete user@example.com:/path/to/files/ "${DOCROOT}/sites/default/files/"

      # Commands that build the site. This is where you would add things
      # like configuration imports or any other drush commands required to
      # set up or configure the site. When a preview is built from a
      # base preview, the build workflow starts here, skipping the init
      # and update steps, because the results of those are inherited
      # from the base preview.
      build:
        # Install/update packages managed by composer, including any that might
        # have been updated by module updates or patches in this branch.
        - composer install --optimize-autoloader

        # Run any pending database updates and import configuration.
        - vendor/bin/drush cache:rebuild
        - vendor/bin/drush config:import --yes
        - vendor/bin/drush updatedb --yes

        # If you are downloading your files from a remote server, you won't need
        # to enable Stage File Proxy. Otherwise, enable it to fetch files on-demand.
        - vendor/bin/drush pm:enable --yes stage_file_proxy
        - vendor/bin/drush config:set --yes stage_file_proxy.settings origin "http://www.example.com"
        - vendor/bin/drush config:set --yes stage_file_proxy.settings origin_dir "sites/default/files"

        # One last cache rebuild.
        - vendor/bin/drush cache:rebuild

        # Generate a one-time login link for easy admin access.
        # This will appear in the build logs.
        - vendor/bin/drush user:login --uri="${TUGBOAT_SERVICE_URL}"
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
