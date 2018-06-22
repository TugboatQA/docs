# Drupal 7

These instructions show how to configure Tugboat for a typical Drupal 7
repository. Every Drupal site tends to have slightly different requirements, so
further customizations may be required, but this should get you started.

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
    	- composer --no-ansi global require drush/drush
    	- ln -sf ~/.composer/vendor/bin/drush /usr/local/bin/drush
    	- ln -sf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"
    	- cp "${TUGBOAT_ROOT}/.tugboat/tugboat.local.php" "${DOCROOT}/sites/default/"
      update:
        - rsync -av --delete user@example.com:/path/to/files/ "${DOCROOT}/sites/default/files/"
        - chgrp -R www-data "${DOCROOT}/sites/default/files"
        - find "${DOCROOT}/sites/default/files" -type d -exec chmod 2775 {} \;
        - find "${DOCROOT}/sites/default/files" -type f -exec chmod 0664 {} \;
      build:
        - drush -r "${DOCROOT}" cache-clear all

  mysql:
    image: tugboatqa/mysql
    commands:
      update:
        - scp user@example.com:database.sql.gz /tmp/database.sql.gz
        - zcat /tmp/database.sql.gz | mysql tugboat
        - rm /tmp/database.sql.gz
```

### PHP Service

We chose to use PHP 7.1 with Apache.
[Other options are available](../../reference/services/index.md#php)

```yaml
image: tugboatqa/php:7.1-apache
```

This is the service that will be serving the Drupal 7 site, so we tell Tugboat
that this is the preview's default service. This is a shortcut option to clone
the git repository into this service, and expose port 80 to the Tugboat proxy
server. It also means that the default preview URL will route to this service.

```yaml
default: true
```

Before we start running any commands on this service, we need the database to be
imported into the `mysql` service.

```yaml
depends: mysql
```

Finally, we define the commands that get run on this service. The `init`
commands install drush, link the document root to the expected path, and
configure Drupal to use a tugboat-specific configuration file.

```yaml
init:
  - composer --no-ansi global require drush/drush
  - ln -sf ~/.composer/vendor/bin/drush /usr/local/bin/drush
  - ln -sf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"
  - cp "${DOCROOT}/sites/default/tugboat.settings.php" "${DOCROOT}/sites/default/settings.local.php"
```

The `update` commands copy the files directory, and sets the permissions. Notice
we are using rsync over SSH here. In order to let Tugboat copy these files, add
the public SSH key found in the Tugboat Repository configuration to the server
hosting these files.

```yaml
update:
  - rsync -av --delete user@example.com:/path/to/files/ "${DOCROOT}/sites/default/files/"
  - chgrp -R www-data "${DOCROOT}/sites/default/files"
  - find "${DOCROOT}/sites/default/files" -type d -exec chmod 2775 {} \;
  - find "${DOCROOT}/sites/default/files" -type f -exec chmod 0664 {} \;
```

The `build` commands clear the cache. This is also where you would add things
like feature reverts or any other drush commands required to set up or configure
your site.

```yaml
build:
  - drush -r "${DOCROOT}" cache-clear all
```

### MySQL Service

We chose to use the latest available version of MySQL because we are not picky
about which version we get.
[Other options are available](../../reference/services/index.md#mysql)

```yaml
image: tugboatqa/mysql
```

This is an auxiliary service for a preview, so there are no additional
configurations required like we used in the PHP service. All that is left is the
commands to import the database.

Like above, we are using SSH to copy a database dump into the mysql service
container. The public SSH key in the Tugboat Repository configuration also needs
to be copied to the server hosting this file.

```yaml
update:
  - scp user@example.com:database.sql.gz /tmp/database.sql.gz
  - zcat /tmp/database.sql.gz | mysql tugboat
  - rm /tmp/database.sql.gz
```

## Start Building Previews!

Once this Tugboat configuration file is committed to your git repository, you
can start building previews!
