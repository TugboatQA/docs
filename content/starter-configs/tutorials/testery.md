---
title: "Testery.io Integration"
date: 2020-06-30T11:00:00-04:00
weight: 5
---

Wondering how to set up automated testing against your dynamically-generated Tugboat environment? Here's one way to get
started with Tugboat and [Testery.io](https://testery.io/).

## Configure Tugboat

Getting started with Tugboat and Testery is similar to [setting up any new Tugboat project](/setting-up-tugboat/).

To integrate Tugboat and Testery, you'll probably want to store your Testery token as an
[environment variable](/setting-up-tugboat/select-repo-settings/#modify-environment-variables). In our example here,
we've saved the Testery token as an environment variable we're calling: `$TESTERY_TOKEN`.

Then, you'll need to create the [Tugboat `config.yml`](/setting-up-tugboat/create-a-tugboat-config-file/) with some
extra build steps to run tests with Testery. Specifically, you'll need to:

1. Install `pip`
2. Install Testery's command line interface tool
3. Invoke a command to run tests against your Tugboat environment at build time

We'll provide a [full example of this below](#example-tugboat-config-for-automated-testing-with-testery), but in the
meantime, you'll also need to set up Testery.

## Configure Testery

You'll need to [create an account with Testery](https://testery.io/pricing); their free tier should be enough to get up
and running as a proof-of-concept.

At the time of this writing, Testery is configured for testing with these frameworks:
[WebdriverIO](https://webdriver.io/), [SpecFlow](https://specflow.org/), [Cypress](https://www.cypress.io/), and
[Nightwatch.js](https://nightwatchjs.org/).

Once you've got an account, you can create a project in Testery. You'll need to select the framework you want to use for
your tests. Then you can set up your Tugboat `config.yml` to run your Testery project's tests against the Tugboat
environment that’s automatically generated from your pull requests.

## Example Tugboat config for automated testing with Testery

The Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in the git repository. In this example Tugboat + Testery configuration, we're setting up automated
testing for [a WordPress site](../wordpress); with comments to explain what's going on:

```yaml
services:
  # What to call the service hosting the site.
  php:
    # Use PHP 7.x with Apache; this syntax pulls in the latest version of PHP 7
    image: tugboatqa/php:7-apache

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
        # Install prerequisite packages
        - apt-get update
        - apt-get install -y rsync
        - apt-get install -y jq

        # Turn on URL rewriting.
        - a2enmod rewrite

        # Install PHP mysqli extension
        - docker-php-ext-install mysqli

        # Install wp-cli
        - curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        - chmod +x wp-cli.phar
        - mv wp-cli.phar /usr/local/bin/wp

        # Link the docroot
        - ln -snf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"

        # Configure wordpress to work with tugboat
        - wp --allow-root --path="${DOCROOT}" config create --dbhost=mysql --dbname=tugboat --dbuser=tugboat
          --dbpass=tugboat --force

        # Update permalinks to remove the index.php.
        - wp --allow-root --path="${DOCROOT}" option set permalink_structure /%postname%/
        - wp --allow-root --path="${DOCROOT}" rewrite flush --hard

        # Install pip so you can get the Testery CLI
        - apt-get install python3
        - apt-get install python3-pip

      # Commands that import files, databases,  or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        # Import uploads
        - curl -L "https://www.dropbox.com/s/ufn5e3qe3sisdks/demo-wordpress-uploads.tar.gz?dl=0" > /tmp/uploads.tar.gz
        - tar -C /tmp -zxf /tmp/uploads.tar.gz
        - rsync -av --delete /tmp/uploads/ "${TUGBOAT_ROOT}/docroot/wp-content/uploads/"

        # Cleanup
        - apt-get clean
        - rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

      # Commands that build the site. This is where you would add things
      # like feature reverts or any other commands required to
      # set up or configure the site. When a preview is built from a
      # base preview, the build workflow starts here, skipping the init
      # and update steps, because the results of those are inherited
      # from the base preview.
      build:
        # Check for upgrades to the Testery command line interface
        - pip3 install testery --upgrade
        # Set up Testery to run tests against the Tugboat environment, using Tugboat environment variables
        - testery update-environment --create-if-not-exists --token "$TESTERY_TOKEN" --key "${TUGBOAT_PREVIEW}" --name
          "${TUGBOAT_PREVIEW}" --variable "TUGBOAT_DEFAULT_SERVICE_URL=${TUGBOAT_DEFAULT_SERVICE_URL}"

        # Start a test run.
        - testery create-test-run --token "$TESTERY_TOKEN" --git-ref "$TUGBOAT_PREVIEW_SHA" --project "testery"
          --environment "${TUGBOAT_PREVIEW}"

  # What to call the service hosting MySQL. This name also acts as the
  # hostname to access the service by from the php service.
  mysql:
    # Use the latest available 5.x version of MySQL
    image: tugboatqa/mysql:5

    # A set of commands to run while building this service
    commands:
      # Commands that import files, databases,  or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        # Copy a database dump from an external server. The public
        # SSH key found in the Tugboat Repository configuration must be
        # copied to the external server in order to use scp.
        - curl -L "https://www.dropbox.com/s/sabj5vq711bhst2/demo-wordpress-database.sql.gz?dl=0" > /tmp/database.sql.gz
        - zcat /tmp/database.sql.gz | mysql tugboat
        - rm /tmp/database.sql.gz
```

With these steps in place, and depending on configurations you set up in both services, you'll then be able to see the
results of your Tugboat builds _and_ your Testery test runs on your git pull requests:

![Screenshot: Testery test results and Tugboat deploy on a pull request in GitHub](/_images/testery-and-tugboat-on-pr.png)

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
