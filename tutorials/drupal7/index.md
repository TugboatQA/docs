# Drupal 7

These instructions show how to configure Tugboat for a typical Drupal 7
repository. Every Drupal site tends to have slightly different requirements, so
further customizations may be required. This should get you started, though.

## Drupal Configuration

A common practice for managing Drupal's `settings.php` is to remove sensitive
information, such as database credentials, before committing it to git. Then,
the sensitive information is loaded from a `settings.local.php` file that exists
only on the Drupal installation location.

This pattern works very well with Tugboat. It lets you keep a tugboat-specific
set of configurations in your repository where it can be copied in during the
preview build process.

Add the following to the end of `settings.php`

```php
if (file_exists(DRUPAL_ROOT . '/' . conf_path() . '/settings.local.php')) {
  include DRUPAL_ROOT . '/' . conf_path() . '/settings.local.php';
}
```

Add a file named `tugboat.settings.php` in the same directory as `settings.php`
with the following content:

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

## Tugboat Configuration

### Services

To serve a Drupal site,

### Full Configuration

```yaml
services:
  php:
    image: tugboatqa/php:7.1-apache
    default: true
    checkout: true
    depends: mysql
    commands:
      init:
    	- composer --no-ansi global require drush/drush
    	- ln -sf ~/.composer/vendor/bin/drush /usr/local/bin/drush
    	- cp ${DOCROOT}/sites/default/tugboat.settings.php ${DOCROOT}/sites/default/settings.local.php
      update:
        - rsync -av --delete user@example.com:/path/to/files/ ${DOCROOT}/sites/default/files/
        - chgrp -R www-data ${DOCROOT}/sites/default/files
        - find ${DOCROOT}/sites/default/files -type d -exec chmod 2775 {} \;
        - find ${DOCROOT}/sites/default/files -type f -exec chmod 0664 {} \;
      build:
        - drush -r ${DOCROOT} cache-clear all

  mysql:
    image: tugboatqa/mysql
    commands:
      update:
        - scp user@example.com:database.sql.gz /tmp/database.sql.gz
        - zcat /tmp/database.sql.gz | mysql tugboat
        - rm /tmp/database.sql.gz
```
