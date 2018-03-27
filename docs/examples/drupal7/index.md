# Drupal 7

These instructions show how to configure Tugboat for a typical Drupal 7
repository. Every Drupal site tends to have slightly different requirements, so
further customizations may be required. This should get you started, though.

## Services

In order to serve a Drupal site, an apache webhead with PHP needs to be
selected. Tugboat provides services with PHP, Composer, and Drush pre-installed.
Drupal 7 is supported on PHP version 5.2.5+, so either of these Tugboat Services
should work fine.

* apache-php-drupal (php-5.5.9)
* apache-php7-drupal (php-7.0.26)

In addition, a MySQL or MariaDB database service neeeds to be selected

* mysql (mysql-5.5.4)
* mariadb (mariadb-5.5.54)

When selecting the Drupal template, the `apache-php7-drupal` and `mysql`
services are automatically selected, so that is what we will use for this
example.

![Drupal Template](_images/drupal-template.png)

The resulting set of services for the repository should look like the following

![Drupal Services](_images/drupal-services.png)

## Drupal Configuration

A common practice for managing Drupal's `settings.php` is to leave sensitive
information, such as database credentials, out of it and commit it to git. Then,
the sensitive information is loaded from a `settings.local.php` file that exists
only on the Drupal installation location.

This pattern works very well with Tugboat. It lets you keep a tugboat-specific
set of configurations in your repository where you can just copy it into place
with a build script.

Add the following to the end of `settings.php`

```php
if (file_exists(DRUPAL_ROOT . '/' . conf_path() . '/settings.local.php')) {
  include DRUPAL_ROOT . '/' . conf_path() . '/settings.local.php';
}
```

Add a file named `tugboat.settings.php` in the same directory as `settings.php`
with the following content.

```php
<?php
$databases = array (
  'default' =>
  array (
    'default' =>
    array (
      'database' => 'demo',
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

## Build Script

The build script for a Drupal 7 repository consists of these main parts

* Point Tugboat to the right document root
* Install prerequisite packages
* Create/Import a database
* Import the site's `files` directory
* Update the Drupal configuration

### Configure a Document Root

By default, Tugboat tries to serve content from a `/docroot` folder in the root
of your git repository. If your repository already has Drupal in this location,
this step can be skipped.

To point Tugboat to the right location in your repository, add a line to the
`tugboat-init` section of the build script. To serve content from `/public_html`
in your repository add this.


```sh
ln -sf ${TUGBOAT_ROOT}/public_html /var/www/html
```

Or, to serve directly from the root of your repository

```sh
ln -sf ${TUGBOAT_ROOT} /var/www/html
```

## Install Prerequisite Packages

Tugboat lets you customize your preview environment however you need. We are
going to need a few packages that are not installed by default, such as `rsync`
and `mysql-client`. In addition, we are going to install a specific version of
Drush.

Add the following to the `tugboat-init` section of the build script. Add any
other packages here that you might need while you are at it.

```sh
apt-get update
apt-get install -y mysql-client rsync
curl -L "https://github.com/drush-ops/drush/releases/download/8.1.15/drush.phar" > /usr/local/bin/drush
chmod +x /usr/local/bin/drush
```

### Create/Import a database

Before you can import a database into a Tugboat Preview, it needs to be
accessible somewhere on the internet. There are a number of ways to do that, but
for this example we are going to assume that a recent mysqldump file is
available somewhere that can be accessed via SSH.

First, visit your [Repository
Settings](../tugboat-dashboard/repository/dashboard/index.md), and copy the
repository's public SSH key to the server hosting the mysqldump file. This
should typically go in a file at `~/.ssh/authorized_keys` in the home directory
of the user on the remote server that has access to the mysqldump file.

![Repository Public SSH Key](../_images/repo-public-key.png)

Add the following to the `tugboat-init` section of the build script to create a
database

```sh
mysql -h mysql -u tugboat -ptugboat -e "create database demo;"
```

Add the following  to the `tugboat-init` and `tugboat-update` sections of the
build script to import a fresh copy of the database.

```sh
scp user@example.com:database.sql.gz /tmp/database.sql.gz
zcat /tmp/database.sql.gz | mysql -h mysql -u tugboat -ptugboat demo
```

### Import files

Just like the database, in order to import the site's `files` directory, it
needs to be accessible over the public internet somehow. Again, there are a
number of different ways of doing that, but for this example we are going to
assume we can rsync that directory from a server via SSH.

Visit your [Repository
Settings](../tugboat-dashboard/repository/dashboard/index.md), and copy the
repository's public SSH key to the server hosting the directory we are going to
sync. This should typically go in a file at `~/.ssh/authorized_keys` in the home
directory of the user on the remote server that has access to the directory.

![Repository Public SSH Key](../_images/repo-public-key.png)

Add the following to the `tugboat-init` and `tugboat-update` sections of the
build script.

```sh
rsync -av --delete user@example.com:/path/to/drupal/sites/default/files/ /var/www/html/sites/default/files/
chgrp -R www-data /var/www/html/sites/default/files
find /var/www/html/sites/default/files -type d -exec chmod 2775 {} \;
find /var/www/html/sites/default/files -type f -exec chmod 0664 {} \;
```

Another common approach is to use the [Stage File
Proxy](https://www.drupal.org/project/stage_file_proxy) Drupal module. This
module lets Drupal serve files from another publicly-accessible Drupal site
instead of syncing the entire `files` directory into the Tugboat Preview. This
allows for smaller Previews, and reduces Preview the build time. If you have a
production site, or publicly-accessible dev/staging sites with some or most of
the same set of files, this may be a good alternative for your repository.

To use Stage File Proxy, add the following to the `tugboat-init` and
`tugboat-update` sections of the build script.

```sh
drush -r /var/www/html pm-download stage_file_proxy
drush -r /var/www/html pm-enable --yes stage_file_proxy
drush -r /var/www/html variable-set stage_file_proxy_origin "http://www.example.com"
```

### Update the Drupal Configuration

Copy the `tugboat.settings.php` file that we created earlier into place so
Drupal can find its database. Add the following to the `tugboat-init` section of
the build script.

```sh
cp /var/www/html/sites/default/tugboat.settings.php /var/www/html/sites/default/settings.local.php
```

Finally, clear Drupal's cache by adding the following to each of `tugboat-init`,
`tugboat-update`, and `tugboat-build` sections of the build script

```sh
drush -r /var/www/html cache-clear all
```

### Full Makefile

This Makefile pulls everything above together into a single file. It takes
advantage of some code reuse, and cleans up temp files at the end to keep the
preview disk space usage down a little.

**Make sure the indents are TABs if this is copied & pasted.**

{% gist id="https://gist.github.com/q0rban/f5f44a97384196730c5ab98da2bd7b8e" %}
{% endgist %}
