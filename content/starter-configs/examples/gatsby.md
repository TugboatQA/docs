---
title: "Gatsby Static Site"
date: 2023-06-23T15:29:39-06:00
weight: 1
---

Deploy your static Gatsby site with Tugboat.

## Configure Tugboat for Gatsby

The Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in the git repository. Here's a basic static HTML configuration you can use as a starting point,
with comments to explain what's going on:

```yaml
services:
  # Configure a standard apache webserver to host our site.
  apache:
    # Use the most recent version of httpd service.
    image: tugboatqa/httpd:latest

    # Run these commands to initialize the server, update it with any libraries and assets required, then build your site.
    commands:
      # Initialize the server.
      init:
        # Install node.js version 18.
        - curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
        - apt-get install -y nodejs

        # Set the webroot for to the Gatsby public folder.
        # Change this if you specify a different root for your public site.
        - ln -snf "${TUGBOAT_ROOT}/public" "${DOCROOT}"

      # Load dependent libraries and assets to prepare the site for build.
      update:
        # Run the node.js installer to install Gatsby and its dependencies.
        - npm install

      # Run any commands needed to build the site.
      build:
        # Build the static Gatsby site.
        - npm run build
```

Want to know more about something mentioned in the comments of this config file? Check out these topics:

- [Name your Service](/setting-up-services/how-to-set-up-services/name-your-service/)
- [Specify a Service image](/setting-up-services/how-to-set-up-services/specify-a-service-image/)
- [Leverage Service commands](/setting-up-services/how-to-set-up-services/leverage-service-commands/)
- [Define a default Service](/setting-up-services/how-to-set-up-services/define-a-default-service/)
- [Set the document root path](/setting-up-services/how-to-set-up-services/set-the-document-root-path/)
- [Preview build process phases (`init`, `update`, `build`)](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained)

## Start Building Previews!

Once this Tugboat configuration file is committed to your git repository, you can start
[building previews](/building-a-preview/administer-previews/build-previews/)!
