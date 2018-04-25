# Add a build script

At this point, you should have the following:

1. A Tugboat project with two Tugboat services (an Apache webhead service and a
   MySQL or MariaDB service)
2. The PHP version that your Pantheon site is using.
3. A Pantheon user that Tugboat can use, and associated machine token exposed as
   a `PANTHEON_MACHINE_TOKEN` environment variable in Tugboat.

## Create a `Makefile` build script in your repository
Once you have the above, you are ready to add a [build script](/build-script/index.md)
to your Pantheon repository. From within the root directory of your repository,
create a new file named `Makefile`.

## Declare some variables
At the top of this new file, we're going to declare some variables that we will
use in the build script:

First, we need to specify the machine name of the Pantheon site we are working
with. If your Pantheon site is named 'Mister Rogers Fan Club', the machine name
would be `mister-rogers-fan-club`. If you are unsure, you can use terminus to
list out all your Pantheon sites by running `terminus site:list --fields=id,name`.
We will set this value in our Makefile to the `PANTHEON_SOURCE_SITE` variable.

```bash
PANTHEON_SOURCE_SITE := mister-rogers-fan-club
```

Next, we need to tell Tugboat which Pantheon environment that it should use to
download the database and files from. This would be `dev`, `test`, or `live`.
It's often best to pull from `live`, as that will have the most stable and fresh
data.

```bash
PANTHEON_SOURCE_ENVIRONMENT := live
```

Now, let's define the PHP version that we determined when we [created our
Tugboat services](../add-services/index.md).

```bash
PHP_VERSION := 7.2
```

Next, specify the Drupal site, which corellates to the name of the directory in
your Drupal /sites directory. This is typically just default unless you are
using Drupal multisite.

```bash
DRUPAL_SITE := default
```

Tugboat also needs to know where the Drupal root is, relative to the repository
root. Often on Pantheon this is equivalent to the root of the repository, but it
also could be `/web` or `/docroot`. We will use the `${TUGBOAT_ROOT}`
[environment variable](/build-script/environment-variables/index.md) to denote
the root of the repository. For example, if `/web` is where Drupal is installed,
set `DRUPAL_ROOT` equal to `${TUGBOAT_ROOT}/web`. In this example, the Drupal
root is also the repository root:

```bash
DRUPAL_ROOT := ${TUGBOAT_ROOT}
```

In our build script, you'll also want to have a variable for the location of the
public and private files directories. You should use the `${DRUPAL_SITE_DIR}`
variable (that we will define later) for these.  For example, if your public
files directory is `sites/default/files`, you would set this value to
`${DRUPAL_SITE_DIR}/files`.

```bash
DRUPAL_FILES_PUBLIC = ${DRUPAL_SITE_DIR}/files
DRUPAL_FILES_PRIVATE = ${DRUPAL_SITE_DIR}/files/private
```

Another common pattern is to have a Tugboat specific `settings.local.php` that
contains the database connection string. For this example, I'll store that file
in a `/.tugboat/dist` directory so that it can be copied into place as a part
of the build script. To make it easier to find these files in our build script,
create a variable to specify the directory relative to the repo root (i.e.
`{$TUGBOAT_ROOT}`).

```bash
DIST_DIR := ${TUGBOAT_ROOT}/.tugboat/dist
```

Fantastic! Now you've got several variables that we can use in our Makefile
build script, which will reduce the amount of code duplication in there.

## Install packages

As a first step in setting up your Tugboat webhead, you need to install some
packages that your project needs, such as `terminus`, `composer`, and the
correct version of PHP. Let's create a new Makefile target called `packages`
just for this.

[import:46-53, lang:"makefile", template:"ace"](../full-makefile/Makefile)

For the most part, you can copy this as is into your Makefile, but if you have
other software you need to build your project (e.g. NodeJS), you'll want to
add to the above with those packages.

## Configure Drupal

Next, we need to put files into place to wire Drupal up to Tugboat.

A common practice for managing Drupal's `settings.php` is to leave sensitive
information, such as database credentials, out of it and commit it to git. Then,
the sensitive information is loaded from a `settings.local.php` file that exists
only on the Drupal installation location.

This pattern works very well with Tugboat. It lets you keep a tugboat-specific
set of configurations in your repository where you can just copy it into place
with a build script.

Add or uncomment the following at the end of your `settings.php`

```php
if (file_exists($app_root . '/' . $site_path . '/settings.local.php')) {
  include $app_root . '/' . $site_path . '/settings.local.php';
}
```

Add a file named `settings.local.php` into your `.tugboat/dist` directory that
you specified above. Inside of that `settings.local.php`, you can define your
Database array for Tugboat. You may also will want to add the Tugboat preview
URLs to the trusted host patterns variable to further secure Drupal:

```php
<?php
$databases['default']['default'] = array (
  'database' => 'demo',
  'username' => 'tugboat',
  'password' => 'tugboat',
  'prefix' => '',
  'host' => 'mysql',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);

$settings['trusted_host_patterns'][] = '^.+\.tugboat\.qa$';
```

With that in place, head back to your Makefile, and add a new target to
configure Drupal:

[import:57-69, lang:"makefile", template:"ace"](../full-makefile/Makefile)






# THIS IS WHERE JAMES STOPPED

## Build Script

The build script for a Drupal 8 repository consists of these main parts

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
apt-get install -y mysql-client rsync wget
# Install drush-launcher. This assumes you are using composer to install
# your desired version of Drush.
wget -O /usr/local/bin/drush https://github.com/drush-ops/drush-launcher/releases/download/0.5.1/drush.phar
chmod +x /usr/local/bin/drush
composer install
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

Generate a new hash salt for the Tugboat previews by adding the following to the
`tugboat-init` section of the build script

```sh
echo "\$$settings['hash_salt'] = '$$(openssl rand -hex 32)';" >> /var/www/html/sites/default/settings.local.php
```

Finally, clear Drupal's cache by adding the following to each of `tugboat-init`,
`tugboat-update`, and `tugboat-build` sections of the build script

```sh
drush -r /var/www/html cache-rebuild
```

#### Next: [View the full Makefile](../full-makefile/index.md)
