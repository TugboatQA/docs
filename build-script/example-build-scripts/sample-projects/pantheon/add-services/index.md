# 2. Add Tugboat Services

Now that we have a project for this Pantheon site, we need to choose the Tugboat
services that we will use. For most Pantheon based sites, you'll want an Apache
webhead with a MySQL database service.

Prior to selecting services, you should determine what version of PHP your
Pantheon site is using. To determine this value:

1. Log into the [Pantheon Dashboard](https://dashboard.pantheon.io)
1. Navigate to the project you are trying to connect with Pantheon
1. Click the Settings gear in the upper right
![Click on Settings in Pantheon Dashboard](_images/pantheon-settings.png)
1. Once in Settings, you should see a PHP Version tab to the far right. After
clicking that, you should see the PHP Version.
![Click on PHP Version in Pantheon Settings](_images/pantheon-php-settings.png)

> #### Warning::Terminus for PHP version
> While in theory you could use the `terminus site:info` command to determine
> the PHP version, we've found that may not give you accurate results.

Now that we know the version of PHP, there are two ways to choose Tugboat
services. Only choose option 1 if your version of PHP is 7.0 or higher,
otherwise you'll need to use Option 2.

## Option 1: Choose a template (for PHP >= 7.0)

By far the easiest way to configure your Tugboat services for Pantheon is to
select the appropriate template when you are [creating your project](../index.md#1.-create-a-tugboat-project).
This is only a good option for you if your preferred version of PHP is 7.0 or
higher. If your version of PHP is less than 7.x, you'll need to skip down this
document to _Option 2: Choose services yourself_.

During project creation, choose the Drupal template:

![Drupal Template](../../drupal8/_images/drupal-template.png)

The resulting set of services for the repository should look like the following:

![Drupal Services](../../drupal8/_images/drupal-services.png)

Once selected, you can continue to the next step, [configuring terminus](../configure-terminus/index.md).

## Option 2: Choose services yourself (for PHP < 7.0)

For this option, you will choose the Tugboat services that you'd like yourself.
If your Pantheon site is using PHP 5.x, choose the apache-php-drupal service. If
you are using a 7.x version of PHP, choose the apache-php7-drupal service. Don't
worry if your Pantheon site is using, say 7.2, and not 7.0—we'll update it later
to the correct minor version of PHP as a part of [creating the build
script](../add-build-script/index.md).

* apache-php-drupal (comes with php-5.5.x)
* apache-php7-drupal (comes with php-7.0.x)

For the purposes of our example, let's say that our Pantheon site is using PHP
7.2. So we will choose the `apache-php7-drupal` service. 

In addition, a MySQL or MariaDB database service needs to be selected:

* mysql (mysql-5.5.x)
* mariadb (mariadb-5.5.x)

#### Next: [Configure terminus](../configure-terminus/index.md)
