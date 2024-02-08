---
title: "Pantheon"
date: 2019-09-19T11:00:09-04:00
weight: 5
---

Wondering how to configure Tugboat for a typical site hosted on Pantheon? While these instructions are for a Drupal 8
site, the concepts should apply for any PHP site hosted by Pantheon. Check out the [Drupal 7](../drupal-7/) and
[WordPress](../wordpress/) tutorials for comparisons.

{{% notice warning %}} These instructions assume you have already configured an external git repository provider such as
GitHub, GitLab, or BitBucket. Pantheon has documentation on
[how to use GitHub](https://pantheon.io/docs/guides/build-tools/). {{% /notice %}}

## Configure Terminus

Tugboat will need to use Pantheon's [terminus](https://pantheon.io/docs/terminus) tool to import a copy of the database
and files into a Tugboat Preview.

### Create a Pantheon User for Tugboat

{{% notice warning %}} Because of how terminus machine tokens work, you cannot restrict their access to a single
Pantheon project. This means that by sharing your machine token with Tugboat, anyone else that has access to your
Tugboat project could gain access to your personal Pantheon account, including any other Pantheon projects that account
has access to. {{% /notice %}}

By creating a Pantheon account solely for Tugboat's use, that user's access can be restricted to the Pantheon project
connected to Tugboat. This user's machine token can then be safely shared with Tugboat.

1.  If you're logged into your personal account on Pantheon, [log out](https://dashboard.pantheon.io/logout).
2.  [Register a new account](https://dashboard.pantheon.io/register) on Pantheon.
3.  Specify a unique email address, ideally using an email alias.
4.  Name your user something recognizable, like _Tugboat User_.

![Screenshot: Create a new pantheon account](/_images/pantheon-register.png)

{{% notice tip %}} Many email clients allow you to generate aliases, or allow you to dynamically have an alias. For
example, on gmail, if your email address is `dorothy@gmail.com`, you could use the `+` symbol followed by a unique
string to create an alias for this tugboat user, e.g. `dorothy+tugboat-pantheon@gmail.com`. {{% /notice %}}

### Generate a Pantheon Machine Token

Now that we have a new user that Tugboat can use, we will need to generate a machine token for this account on Pantheon.
While logged in as this new user, go to
[Machine Tokens](https://dashboard.pantheon.io/user?destination=%2Fuser#account/tokens/create/terminus/), which is under
your account settings. You can name this token whatever you'd like, such as `Terminus on Tugboat`:

![Screenshot: New machine token form](/_images/pantheon-new-token.png)

Once you've picked a name, click _Generate Token_. You will then be presented with a screen that displays your machine
token. **Store this token in a secure place, such as a password manager or OS keychain.**

![Screenshot: Token generated modal](/_images/pantheon-token-generated.png)

### Add your new Pantheon user to your Pantheon project

Now that you've generated a machine token for your new Pantheon user, you still need to add this user to your Pantheon
project. To do this:

1. Log out of Pantheon.
2. Log back in with your personal Pantheon account.
3. Navigate to your Pantheon project, and click _Team_ from the header.
4. Enter the email address of the new Pantheon user you created above, and click the _Add to team_ button.

![Screenshot: Pantheon Add to team](/_images/pantheon-add-to-team.png)

### Store the machine token as a Tugboat environment variable

{{% notice warning %}} For the security of your Pantheon site, it's important to use an environment variable to store
the machine token, instead of committing it to your repository or storing it in some other fashion. {{% /notice %}}

## Configure Pantheon (using a Drupal example)

A common practice for managing Drupal's `settings.php` is to leave sensitive information, such as database credentials,
out of it and commit it to git. Then, the sensitive information is loaded from a `settings.local.php` file that exists
only on the Drupal installation location.

This pattern works very well with Tugboat. It lets you keep a tugboat-specific set of configurations in your repository
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
$databases['default']['default'] = array (
  'database' => 'tugboat',
  'username' => 'tugboat',
  'password' => 'tugboat',
  'prefix' => '',
  'host' => 'mysql',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);
// Use the TUGBOAT_REPO_ID to generate a hash salt for Tugboat sites.
$settings['hash_salt'] = hash('sha256', getenv('TUGBOAT_REPO_ID'));
```

## Configure Tugboat

There are three parts to configuring Tugboat to work with Pantheon.

1. Figure out which version of PHP to use.
2. Set up a few Tugboat custom environment variables.
3. Create a [configuration file](/setting-up-tugboat/create-a-tugboat-config-file/) to include in your git repository.

### PHP Version

In order to replicate the Pantheon environment as closely as possible, we need to use the same version of PHP.

{{% notice warning %}} While in theory you could use the `terminus site:info` command to determine the PHP version,
we've found that may not give you accurate results. {{% /notice %}}

1.  Log into the [Pantheon Dashboard](https://dashboard.pantheon.io).
2.  Navigate to the project you are trying to connect with Pantheon.
3.  Click the Settings gear in the upper right.
    ![Click on Settings in Pantheon Dashboard](/_images/pantheon-settings.png)
4.  Once in Settings, you should see a PHP Version tab to the far right. After clicking that, you should see the PHP
    Version. ![Click on PHP Version in Pantheon Settings](/_images/pantheon-php-settings.png)

### Environment Variables

The Tugboat configuration file below makes use of some Tugboat
[custom environment variables](/setting-up-services/how-to-set-up-services/custom-environment-variables/). This is how
we securely store the [Pantheon machine token](#generate-a-pantheon-machine-token) from above, so you don't have to
commit it to your git repository. We also define the Pantheon site and environment names here to make the config file
more portable.

In the [Tugboat Repository settings](/setting-up-tugboat/select-repo-settings/), create the following environment
variables. In this example, we are using the "live" environment of a Pantheon site named "example".

```
PANTHEON_MACHINE_TOKEN=ABCDEF123456ABCDEF123456
PANTHEON_SOURCE_SITE=example
PANTHEON_SOURCE_ENVIRONMENT=live
```

### Tugboat Configuration File

The main Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in the git repository. Here's a Pantheon Drupal 9 configuration you can use as a starting point,
with comments to explain what's going on. Please also refer to the generic
[Drupal 9 starter config](/starter-configs/tutorials/drupal-9/).

```yaml
services:
  # What to call the service hosting the site
  php:
    # Use PHP 8.0.x with Apache. Be sure this matches the version of PHP used by
    # Pantheon, which you discovered in the PHP version step above.
    image: tugboatqa/php:8.0-apache

    # Set this as the default service. This does a few things
    #   1. Clones the git repository into the service container
    #   2. Exposes port 80 to the Tugboat HTTP proxy
    #   3. Routes requests to the preview URL to this service
    default: true

    # Wait until the mysql service is done building
    depends: mysql

    # A set of commands to run while building this service
    commands:
      # Commands that set up the basic preview infrastructure. This is where we
      # install the tools that need to be present before building the site, such
      # as Drush and Terminus.
      init:
        # If your project uses Imagemagick, uncomment these lines:
        #- apt-get update
        #- apt-get install -y imagemagick

        # Install opcache and mod-rewrite.
        - docker-php-ext-install opcache
        - a2enmod headers rewrite

        # Link the document root to the expected path. This example links /web
        # to the docroot
        - ln -snf "${TUGBOAT_ROOT}/web" "${DOCROOT}"

        # Create the Drupal private and public files directories if they aren't
        # already present.
        - mkdir -p "${TUGBOAT_ROOT}/files-private" "${DOCROOT}/sites/default/files"

        # If desired, create a global drush symlink
        - ln -snf "${TUGBOAT_ROOT}/vendor/bin/drush" /usr/local/bin/drush

        # Install the latest version of terminus as standalone to avoid OOMs.
        # https://pantheon.io/docs/terminus/install#standalone-terminus-phar
        - |
          set -eo pipefail
          TERMINUS_RELEASE=$(curl --silent "https://api.github.com/repos/pantheon-systems/terminus/releases/latest" | perl -nle'print $& while m#"tag_name": "\K[^"]*#g')
          curl -L https://github.com/pantheon-systems/terminus/releases/download/$TERMINUS_RELEASE/terminus.phar --output /usr/local/bin/terminus
          chmod +x /usr/local/bin/terminus

        # Authenticate to terminus. Note this command uses a Tugboat environment
        # variable named PANTHEON_MACHINE_TOKEN
        - terminus auth:login --machine-token=${PANTHEON_MACHINE_TOKEN}

      # Commands that import files, databases,  or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        # Use the tugboat-specific Drupal settings
        - cp "${TUGBOAT_ROOT}/.tugboat/settings.local.php" "${DOCROOT}/sites/default/"

        # Install/update packages managed by composer, including drush.
        - composer install --optimize-autoloader

        # Import and sanitize a database backup from Pantheon
        - terminus backup:get ${PANTHEON_SOURCE_SITE}.${PANTHEON_SOURCE_ENVIRONMENT} --to=/tmp/database.sql.gz
          --element=db
        - drush --yes sql-drop
        - zcat /tmp/database.sql.gz | drush sql-cli

        # Import the files from Pantheon. Alternatively, the stage_file_proxy
        # Drupal module could be enabled & configured here using Drush commands
        - terminus backup:get ${PANTHEON_SOURCE_SITE}.${PANTHEON_SOURCE_ENVIRONMENT} --to=/tmp/files.tar.gz
          --element=files
        - tar -C /tmp -zxf /tmp/files.tar.gz
        - rsync -av --exclude=.htaccess --delete --no-owner --no-group --no-perms
          /tmp/files_${PANTHEON_SOURCE_ENVIRONMENT}/ "${DOCROOT}/sites/default/files/"

      # Commands that build the site. This is where you would add things
      # like feature reverts or any other drush commands required to
      # set up or configure the site. When a preview is built from a
      # base preview, the build workflow starts here, skipping the init
      # and update steps, because the results of those are inherited
      # from the base preview.
      build:
        - composer install --optimize-autoloader
        - vendor/bin/drush cache:rebuild
        - vendor/bin/drush config:import -y
        - vendor/bin/drush updatedb -y
        - vendor/bin/drush cache:rebuild

        # Clean up temp files used during the build
        - rm -rf /tmp/* /var/tmp/*

  # What to call the service hosting MySQL. This name also acts as the
  # hostname to access the service by from the php service.
  mysql:
    # Use the latest available 5.x version of MariaDB
    image: tugboatqa/mariadb:10.5
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

## Start Building Previews!

Once the Tugboat configuration file is committed to your git repository, you can start
[building previews](/building-a-preview/administer-previews/build-previews/)!
