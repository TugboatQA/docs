# WordPress

These instructions show how to configure Tugboat for a standard WordPress
repository. Every site tends to have slightly different requirements, so further
customization may be required, but this should get you started.

## WordPress Configuration

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

## Tugboat Configuration

Let's start with the complete working configuration. This file needs to reside
in `.tugboat/config.yml` in the root of your git repository. From there, we will
step through it to explain what is going on. Then, you can customize it as
needed.

```yaml
services:
  php:
    image: tugboatqa/php:7.1-apache
    default: true
    depends: mysql
    commands:
      init:
        - curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        - cmod +x wp-cli.phar
        - mv wp-cli.phar /usr/local/bin/wp
        - cp "${TUGBOAT_ROOT}/.tugboat/wp-config.local.php" "${DOCROOT}/"
      update:
        - mkdir -p "${DOCROOT}/wp-content/uploads" || /bin/true
        - rsync -av --delete user@example.com:/path/to/wp-content/uploads/ "${DOCROOT}/wp-content/uploads/"
        - chgrp -R www-data "${DOCROOT}/wp-content/uploads"
        - find "${DOCROOT}/wp-content/uploads" -type d -exec chmod 2775 {} \;
        - find "${DOCROOT}/wp-content/uploads" -type f -exec chmod 0664 {} \;
      build:
        - wp --allow-root --path="${DOCROOT}" search-replace 'wordpress.local' "${TUGBOAT_PREVIEW}-${TUGBOAT_TOKEN}.${TUGBOAT_DOMAIN}" --skip-columns=guid

  mysql:
    image: tugboatqa/mysql:5
    commands:
      update:
        - scp user@example.com:database.sql.gz /tmp/database.sql.gz
        - zcat /tmp/database.sql.gz | mysql tugboat
        - rm /tmp/database.sql.gz
```
