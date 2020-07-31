---
title: "Ruby on Rails"
date: 2020-07-31T17:00:00-04:00
weight: 6
---

This Ruby on Rails config example starts with a Tugboat Debian image, installs Ruby, and uses a Tugboat PostgreSQL
image, adding and then removing permissions to create a database Rails-style. You'll need to do some customizing for
your app, but this should get you started.

## Configure Tugboat

The Tugboat configuration is managed by a [YAML file](/setting-up-tugboat/create-a-tugboat-config-file/) at
`.tugboat/config.yml` in the git repository. Here's a basic Ruby on Rails configuration you can use as a starting point,
with comments to explain what's going on:

```yaml
services:
  # What to call the service hosting the site.
  rails:
    # Use a Tugboat Debian image as a starting point because it contains tools
    # and configurations to help them work well with Tugboat
    image: tugboatqa/debian

    # Set this as the default service. This does a few things
    #   1. Clones the git repository into the service container
    #   2. Exposes port 80 to the Tugboat HTTP proxy
    #   3. Routes requests to the Preview URL to this service
    default: true

    # Don't build the Ruby service until the database service is started
    depends: database

    # A set of commands to run while building this service
    commands:
      # Commands that set up the basic preview infrastructure
      init:
        # Check for updates to apt-get, and then use it to install Ruby
        - apt-get update
        - apt-get install ruby ruby-dev

        # Install a minimal set of PostgreSQL binaries and headers to interact with the database
        - apt-get install libpq-dev

        # Install the gems required for the project
        - gem update --system
        - gem install bundler
        - bundle install

        # Clean up apt artifacts to keep the Preview small
        - apt-get clean
        - rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

      # Commands that import files, databases,  or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      update:
        # A common practice in many Rails projects is to run this command to
        # set up a database. This step is why the 'database' service has an 'init'
        # command to give the default Tugboat user permission to create the database.
        # If you're not creating a database here, you don't need the 'init' and
        # 'online' commands in the `database` service. If you're connecting to a remote
        # database, you won't need this.
        - bin/rails db:setup

      # Commands that should happen every time the Preview starts.
      start:
        # Start the Rails server
        - bin/rails s -b 0.0.0.0 -p 80

  # What to call the service hosting the database. This name also acts as the
  # hostname to access the service by from the 'rails' service.
  database:
    # Use the latest available version of postgres by not specifying a
    # version
    image: tugboatqa/postgres

    # A set of commands to run while building this service
    commands:
      # Commands that import files, databases, or other assets. When an
      # existing preview is refreshed, the build workflow starts here,
      # skipping the init step, because the results of that step will
      # already be present.
      init:
        # Give the default Tugboat user the permission to create a database.
        # This is only required if using 'rails db:setup'
        - psql -U postgres -d tugboat -c "ALTER USER tugboat WITH CREATEDB;"

      # Tugboat runs these commands once, after the Preview comes online for the first time
      online:
        # For security purposes, remove the extra permissions we gave the
        # Tugboat user to create the database in 'init'
        - psql -U postgres -d tugboat -c "ALTER USER tugboat WITH NOCREATEDB;"
```

Want to know more about something mentioned in the comments of this config file? Check out these topics:

- [Name your Service](/setting-up-services/how-to-set-up-services/name-your-service/)
- [Specify a Service image](/setting-up-services/how-to-set-up-services/specify-a-service-image/)
- [Leverage Service commands](/setting-up-services/how-to-set-up-services/leverage-service-commands/)
- [Define a default Service](/setting-up-services/how-to-set-up-services/define-a-default-service/)
- [Preview build process phases (`init`, `update`, `build`)](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained)

## Start Building Previews!

Once this Tugboat configuration file is committed to your git repository, you can start
[building previews](/building-a-preview/administer-previews/build-previews/)!
