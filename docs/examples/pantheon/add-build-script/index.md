# Add a build script

At this point, you should have the following:

1. A Tugboat project with two Tugboat services (an Apache webhead service and a
   MySQL or MariaDB service)
2. The PHP version that your Pantheon site is using. (We'll do minor version upgrades later)
3. A Pantheon user that Tugboat can use, and associated machine token exposed as
   a `PANTHEON_MACHINE_TOKEN` environment variable in Tugboat.

If you're familiar with creating build scripts for Tugboat, you can skip ahead
to read the [full Makefile](../full-makefile/index.md).

## Create a `Makefile` build script in your repository
Once you have the above, you are ready to add a [build script](/build-script/index.md)
to your Pantheon repository. From within the root directory of your repository,
create a new file named `Makefile`.

## Declare some variables
At the top of this new file, we're going to declare some variables that we will
use in the build script:

First, you'll need to specify the machine name of the Pantheon site you are
working with. For example, if your Pantheon site is named *Mister Rogers Fan
Club*, the machine name would be `mister-rogers-fan-club`. If you are unsure,
you can use terminus to list out all your Pantheon sites by running `terminus
site:list --fields=id,name`. Once you determine the Pantheon site name, you
should set this value in your Makefile to the `PANTHEON_SOURCE_SITE` variable.

```bash
PANTHEON_SOURCE_SITE := mister-rogers-fan-club
```

Next, we need to tell Tugboat which Pantheon environment that it should use to
download the database and files from. This would be `dev`, `test`, or `live`.
It's often best to pull from `live`, as that will have the most stable and
freshest data.

```bash
PANTHEON_SOURCE_ENVIRONMENT := live
```

Now, let's define the PHP version that we determined when we [created our
Tugboat services](../add-services/index.md) to a variable called `PHP_VERSION`.

```bash
PHP_VERSION := 7.2
```

Next, specify the Drupal site, which correlates to the name of the directory in
your Drupal /sites directory. This is typically just `default`, unless you are
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
create a variable named `DIST_DIR` to specify the directory relative to the repo
root (i.e. `{$TUGBOAT_ROOT}`).

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

A common practice for managing Drupal's `settings.php` is to store sensitive
information, such as Database credentials and the like, into a
`settings.local.php` file that exists only on the Drupal installation location.
This pattern works very well with Tugboat. It lets you keep a tugboat-specific
set of configurations in your repository where you can just copy it into place
with a build script.

To enable this functionality, add or uncomment the following at the end of your
`settings.php`:

```php
if (file_exists($app_root . '/' . $site_path . '/settings.local.php')) {
  include $app_root . '/' . $site_path . '/settings.local.php';
}
```

Add a file named `settings.local.php` into your `.tugboat/dist` directory that
you specified above. Inside of that `settings.local.php`, you can define your
Database array for Tugboat. You may also want to add the Tugboat preview URLs to
the trusted host patterns variable to further secure Drupal:

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
configure Drupal, called `drupal-prep`;

[import:57-69, lang:"makefile", template:"ace"](../full-makefile/Makefile)

## Import database and files using terminus

Next, you should add some targets to import the database and files from
Pantheon. First, you need to use terminus to generate the backups. Add a target
in your Makefile called `create-backup`:

[import:73-74, lang:"makefile", template:"ace"](../full-makefile/Makefile)

Now that we have that target, add a target to download and import the database.
This target should depend on the `drupal-prep` and `create-backup` targets
above. Name the target `importdb`, like so:

[import:77-87, lang:"makefile", template:"ace"](../full-makefile/Makefile)

Similarly, create a target for downloading the files from Pantheon, that also
depends on the `drupal-prep` and `create-backup` targets above.

[import:91-106, lang:"makefile", template:"ace"](../full-makefile/Makefile)

## Run your build steps

Now that you have the targets needed to get the Pantheon database and files into
your Tugboat project, you need to define what build steps you run as a part of
building your Drupal project. Typically this includes things like running
`composer install`, rebuilding caches, importing configuration, running database
updates, compiling SCSS, or minifying JavaScript. Ideally, you should have a
build script that all your environments (i.e. local, Tugboat, Pantheon) use.

[import:116-119, lang:"makefile", template:"ace"](../full-makefile/Makefile)

## Add some other bits 

The following snippets you can just copy / paste to the bottom of your Makefile.

This target ensures that we have all the environment variables we need to
connect to Pantheon using terminus.

[import:123-135, lang:"makefile", template:"ace"](../full-makefile/Makefile)

This target reduces disk space by cleaning up tmp directories and other non-
essential files.

[import:139-141, lang:"makefile", template:"ace"](../full-makefile/Makefile)

These are some variables used above that you shouldn't need to modify.

[import:153-162, lang:"makefile", template:"ace"](../full-makefile/Makefile)

## Wire up Tugboat targets

We finally have everything in place to connect our build script to Tugboat. If
you haven't yet, you should read through the [documentation on the Tugboat
targets](/build-script/index.md#makefile), `tugboat-init`, `tugboat-update`, and
`tugboat-build`. You'll notice, all we're doing in each of these targets is
referencing all the work you did above. In addition, each target builds on the
previous, i.e `tugboat-init` calls `tugboat-update` which calls `tugboat-build`.

[import:147-149, lang:"makefile", template:"ace"](../full-makefile/Makefile)

---

That's it, you're ready to commit this Makefile and push it up to a new branch
to see it in action on Tugboat! But first, you might want to compare with the
full version of the Makefile:

#### Next: [View the full Makefile](../full-makefile/index.md)
