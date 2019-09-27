---
title: "Static HTML"
date: 2019-09-19T11:00:39-04:00
weight: 1
---

A static HTML Tugboat Preview serves files exactly as they are found in the git
repository.

## Configure Tugboat

The Tugboat configuration is managed by a
[YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in the git repository. Here's a basic static HTML
configuration you can use as a starting point, with comments to explain what's
going on:

```yaml
services:
  # What to call the service hosting the site. Because there is only
  # one service, it is automatically set as the default service, which
  # does a few things
  #   1. Clones the git repository into the service container
  #   2. Exposes port 80 to the Tugboat HTTP proxy
  #   3. Routes requests to the preview URL to this service
  apache:
    # Use the available version of Apache by not specifying a version
    image: tugboatqa/httpd

    # A set of commands to run while building this service
    commands:
      # Commands that set up the basic preview infrastructure
      init:
        # Link the document root to the expected path. This example links the
        # root of the git repository to the docroot
        - ln -snf "${TUGBOAT_ROOT}" "${DOCROOT}"
```

Want to know more about something mentioned in the comments of this config file?
Check out these topics:

- [Name your Service](/setting-up-services/how-to-set-up-services/name-your-service/)
- [Specify a Service image](/setting-up-services/how-to-set-up-services/specify-a-service-image/)
- [Leverage Service commands](/setting-up-services/how-to-set-up-services/leverage-service-commands/)
- [Define a default Service](/setting-up-services/how-to-set-up-services/define-a-default-service/)
- [Set the document root path](/setting-up-services/how-to-set-up-services/set-the-document-root-path/)
- [Preview build process phases (`init`, `update`, `build`)](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained)

## Start Building Previews!

Once this Tugboat configuration file is committed to your git repository, you
can start
[building previews](/building-a-preview/administer-previews/build-previews/)!
