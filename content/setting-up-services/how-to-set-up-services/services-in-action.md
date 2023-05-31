---
title: "Services in Action"
date: 2019-09-17T11:27:02-04:00
weight: 11
---

Now that we've gone through all the components you'll need to set up Services for your Tugboat, let's take a look at an
example [config file](/setting-up-tugboat/create-a-tugboat-config-file/) so you can see Services in action. This config
file is for a [Drupal 8](/starter-configs/tutorials/drupal-8/) site, but you can check out our
[starter configuration files](/starter-configs/) to see if we've got a code example to kick-start your setup.

```yaml
services:
  # What to call the service hosting the site.
  php:
    # Use PHP 7.x with Apache to serve a Drupal 8 site
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
        # Install opcache and enable mod-rewrite.
        - docker-php-ext-install opcache
        - a2enmod headers rewrite

        # Install drush-launcher
        - wget -O /usr/local/bin/drush https://github.com/drush-ops/drush-launcher/releases/download/0.6.0/drush.phar
        - chmod +x /usr/local/bin/drush

        # Link the document root to the expected path. This example links /web
        # to the docroot
        - ln -snf "${TUGBOAT_ROOT}/web" "${DOCROOT}"

      # Commands that import files, databases,  or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        # Use the tugboat-specific Drupal settings
        - cp "${TUGBOAT_ROOT}/.tugboat/settings.local.php" "${DOCROOT}/sites/default/"

        # Generate a unique hash_salt to secure the site
        - echo "\$settings['hash_salt'] = '$(openssl rand -hex 32)';" >> "${DOCROOT}/sites/default/settings.local.php"

        # Install/update packages managed by composer, including drush
        - composer install --no-ansi

        # Copy the files directory from an external server. The public
        # SSH key found in the Tugboat Repository configuration must be
        # copied to the external server in order to use rsync over SSH.
        - rsync -av --delete user@example.com:/path/to/files/ "${DOCROOT}/sites/default/files/"
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
        - drush -r "${DOCROOT}" variable-set stage_file_proxy_origin "http://www.example.com"

      # Commands that build the site. This is where you would add things
      # like feature reverts or any other drush commands required to
      # set up or configure the site. When a preview is built from a
      # base preview, the build workflow starts here, skipping the init
      # and update steps, because the results of those are inherited
      # from the base preview.
      build:
        - drush -r "${DOCROOT}" cache-rebuild
        - drush -r "${DOCROOT}" updb -y

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
