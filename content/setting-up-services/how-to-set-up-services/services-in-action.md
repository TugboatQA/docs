---
title: "Services in Action"
date: 2019-09-17T11:27:02-04:00
weight: 11
---

Now that we've gone through all the components you'll need to set up Services for your Tugboat, let's take a look at an
example [config file](/setting-up-tugboat/create-a-tugboat-config-file/) so you can see Services in action. This config
file is for a [Drupal 10](/starter-configs/tutorials/drupal-10/) site, but you can check out our
[starter configuration files](/starter-configs/) to see if we've got a code example to kick-start your setup.

```yaml
# Default Drupal 10 Tugboat starter config.
# https://docs.tugboatqa.com/starter-configs/tutorials/drupal-10/
services:
  # Define the database service.
  database:
    # Use the latest available 5.x version of MySQL
    image: tugboatqa/mariadb:10.5

    # A set of commands to run while building this service
    commands:
      # Configure the server for the site to run on.
      init:
        # Increase the allowed packet size to 512MB.
        - mysql -e "SET GLOBAL max_allowed_packet=536870912;"
        # Ensure this packet size persists even if MySQL restarts.
        - echo "max_allowed_packet=536870912" >> /etc/mysql/conf.d/tugboat.cnf

      # Commands that import files, databases,  or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        # TODO: Copy a database dump from an external server. The public
        # SSH key found in the Tugboat Repository configuration must be
        # copied to the external server in order to use scp.
        - scp user@example.com:database.sql.gz /tmp/database.sql.gz
        - zcat /tmp/database.sql.gz | mysql tugboat
        - rm /tmp/database.sql.gz

      # Run any commands needed to prepare the site.  This is generally not needed
      # for database services.
      build: []

  # Define the webserver service.
  webserver:
    # This uses PHP 8.1.x with Apache: update to match your version of PHP.
    image: tugboatqa/php:8.1-apache

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

        # Link the document root to the expected path. This example links /web
        # to the docroot.
        - ln -snf "${TUGBOAT_ROOT}/web" "${DOCROOT}"

        # Create any required directories that don't exist.
        # - mkdir -p "${TUGBOAT_ROOT}/files-private"

      # Commands that import files, databases,  or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        # Install/update packages managed by composer, including drush and Stage File Proxy.
        - composer install --optimize-autoloader
        - composer require --dev drupal/stage_file_proxy

        # Set the tugboat-specific Drupal settings.
        - cp "${TUGBOAT_ROOT}/.tugboat/settings.local.php" "${DOCROOT}/sites/default/settings.local.php"

        # Map your custom modules and themes into the Drupal structure.
        #- ln -snf "${TUGBOAT_ROOT}/custom/themes" "${DOCROOT}/themes/custom"
        #- ln -snf "${TUGBOAT_ROOT}/custom/modules" "${DOCROOT}/modules/custom"

        # Make sure our files and translations folders exists and are writable.
        - mkdir -p "${DOCROOT}/sites/default/files/translations"
        - chgrp -R www-data "${DOCROOT}/sites/default/files"
        - find "${DOCROOT}/sites/default/files" -type d -exec chmod 2775 {} \;
        - find "${DOCROOT}/sites/default/files" -type f -exec chmod 0664 {} \;

        # Optional: Copy Drupal's public files directory from an external server. The
        # public SSH key found in the Tugboat Repository configuration must be
        # copied to the external server in order to use rsync over SSH.  More commonly
        # we use Stage File Proxy, which we enable in the `build` step below.
        - rsync -av --delete user@example.com:/path/to/files/ "${DOCROOT}/sites/default/files/"

      # Commands that build the site. This is where you would add things
      # like feature reverts or any other drush commands required to
      # set up or configure the site. When a preview is built from a
      # base preview, the build workflow starts here, skipping the init
      # and update steps, because the results of those are inherited
      # from the base preview.
      build:
        # Install new configuration and database updates.
        - vendor/bin/drush cache:rebuild
        - vendor/bin/drush config:import --yes
        - vendor/bin/drush updatedb --yes

        # If you are downloading your files from a remove server, you won't need
        # to enable Stage File Proxy.
        - vendor/bin/drush pm:enable --yes stage_file_proxy
        - vendor/bin/drush config:set --yes stage_file_proxy.settings origin "http://www.example.com"
        - vendor/bin/drush config:set --yes stage_file_proxy.settings origin_dir "sites/default/files"

        # One last cache rebuild.
        - vendor/bin/drush cache:rebuild
```
