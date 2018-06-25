# WordPress

These instructions show how to configure Tugboat for a standard WordPress
repository. Every site tends to have slightly different requirements, so further
customization may be required, but this should get you started.

## Configure WordPress

For WordPress to use environment-specific settings, some changes need to be made
to `wp-config.php`. One popular method is to commit a "default" version of the
file to the git repository, and include a "local" config file with override
options. That local file should not be included in the git repository.

These are the settings we are particularly interested in for Tugboat, but the
the concept could be easily extended to cover the remaining settings in
`wp-config.php`

```php
if ( file_exists( dirname( __FILE__ ) . '/wp-config.local.php' ) )
    include(dirname(__file__) . '/wp-config.local.php');

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

Add a file to the git repository at `.tugboat/wp-config.local.php` with the
following contents:

```php
<?php
define('DB_NAME', 'tugboat');
define('DB_USER', 'tugboat');
define('DB_PASSWORD', 'tugboat');
define('DB_HOST', 'mysql';
```

## Configure Tugboat

The Tugboat configuration is managed by a YAML file at .tugboat/config.yml in
the git repository. Below is a basic WordPress configuration with comments to
explain what is going on. Use it as a starting point, and customize it as needed
for your own WordPress installation.

```yaml
services:

  # What to call the service hosting the site.
  php:

    # Use PHP 7.1 with Apache to serve the WordPress site
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
          # Install wp-cli
        - curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        - cmod +x wp-cli.phar
        - mv wp-cli.phar /usr/local/bin/wp

          # Use the tugboat-specific wp-config.local.php
        - cp "${TUGBOAT_ROOT}/.tugboat/wp-config.local.php" "${DOCROOT}/"

    	  # Link the document root to the expected path
    	- ln -sf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"

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

      # Commands that build the site. When a preview is built from a
      # base preview, the build workflow starts here, skipping the init
      # and update steps, because the results of those are inherited
      # from the base preview.
      build:
        - wp --allow-root --path="${DOCROOT}" search-replace 'wordpress.local' "${TUGBOAT_PREVIEW}-${TUGBOAT_TOKEN}.${TUGBOAT_DOMAIN}" --skip-columns=guid

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

## Start Building Previews!

Once the Tugboat configuration file is committed to your git repository, you can
start building previews!
