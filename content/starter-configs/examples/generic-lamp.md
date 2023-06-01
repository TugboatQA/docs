---
title: "Generic LAMP"
date: 2019-09-19T10:59:39-04:00
weight: 5
---

A Generic LAMP stack should work with most PHP/MySQL web applications. You may need to do some customizing, but this
should get you started.

## Configure Tugboat

The Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in the git repository. Here's a basic LAMP configuration you can use as a starting point, with
comments to explain what's going on:

```yaml
services:
  # What to call the service hosting the site.
  php:
    # Use PHP 7.1 with Apache
    image: tugboatqa/php:apache

    # Set this as the default service. This does a few things
    #   1. Clones the git repository into the service container
    #   2. Exposes port 80 to the Tugboat HTTP proxy
    #   3. Routes requests to the preview URL to this service
    default: true

    # A set of commands to run while building this service
    commands:
      # Commands that set up the basic preview infrastructure
      init:
        # Link the document root to the expected path. This example links
        # /htdocs to the docroot
        - ln -snf "${TUGBOAT_ROOT}/htdocs" "${DOCROOT}"

  # What to call the service hosting MySQL. This name also acts as the
  # hostname to access the service by from the php service.
  mysql:
    # Use the latest available version of MySQL by not specifying a
    # version
    image: tugboatqa/mysql:5-debian

    # A set of commands to run while building this service
    commands:
      # Commands that import files, databases, or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        # Copy a database dump from an external server. The public
        # SSH key found in the Tugboat Repository configuration must be
        # copied to the external server in order to use scp.
        - scp user@example.com:database.sql.gz /tmp/database.sql.gz
        - zcat /tmp/database.sql.gz | mysql tugboat
        - rm /tmp/database.sql.gz
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

Once this Tugboat configuration file is committed to your git repository, you can start
[building previews](/building-a-preview/administer-previews/build-previews/)!
