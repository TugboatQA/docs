---
title: "Testery.io Integration"
date: 2020-06-30T11:00:00-04:00
weight: 6
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
testing for a WordPress site. If you want to see more about the WordPress config details, check out the
[WordPress tutorial](../wordpress); here we've redacted some of the WordPress-specific comments and build steps to focus
on the Testery setup:

```yaml
services:
  php:
    image: tugboatqa/php:7-apache
    default: true
    depends: mysql
    # A set of commands to run while building this service
    commands:
      # Commands that set up the basic preview infrastructure
      init:
        ...
        # Install pip so you can get the Testery CLI
        - apt-get update
        - apt-get install -y python3 python3-pip

      # Commands that build the site. This is where you would add things
      # like feature reverts or any other commands required to
      # set up or configure the site. When a preview is built from a
      # base preview, the build workflow starts here, skipping the init
      # and update steps, because the results of those are inherited
      # from the base preview.
      build:
        ...
        # Check for upgrades to the Testery command line interface
        - pip3 install testery --upgrade
        # Set up Testery to run tests against the Tugboat environment, using Tugboat environment variables
        - testery update-environment --create-if-not-exists --token "$TESTERY_TOKEN" --key "${TUGBOAT_PREVIEW}" --name
          "${TUGBOAT_PREVIEW}" --variable "TUGBOAT_DEFAULT_SERVICE_URL=${TUGBOAT_DEFAULT_SERVICE_URL}"
        # Start a test run.
        - testery create-test-run --token "$TESTERY_TOKEN" --git-ref "$TUGBOAT_PREVIEW_SHA" --project "testery"
          --environment "${TUGBOAT_PREVIEW}"
```

Want to know more about something mentioned in the comments of this config file? Check out these topics:

- [Name your Service](/setting-up-services/how-to-set-up-services/name-your-service/)
- [Specify a Service image](/setting-up-services/how-to-set-up-services/specify-a-service-image/)
- [Leverage Service commands](/setting-up-services/how-to-set-up-services/leverage-service-commands/)
- [Define a default Service](/setting-up-services/how-to-set-up-services/define-a-default-service/)
- [Preview build process phases (`init`, `update`, `build`)](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained)

## Start testing against your Preview environments

With these steps in place, and depending on configurations you set up in both services, you'll then be able to see the
results of your Tugboat builds _and_ your Testery test runs on your git pull requests:

![Screenshot: Testery test results and Tugboat deploy on a pull request in GitHub](/_images/testery-and-tugboat-on-pr.png)
