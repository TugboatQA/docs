# Generic LAMP

A Generic LAMP stack should work with most PHP/MySQL web applications. Some
customizations may be required, but this should get you started.

## Configure Tugboat

The Tugboat configuration is managed by a YAML file at `.tugboat/config.yml` in
the git repository. Below is a basic LAMP configuration with comments to explain
what is going on. Use it as a starting point, and customize it as needed for
your own installation.

```yaml
services:

  # What to call the service hosting the site.
  php:

    # Use PHP 7.1 with Apache
    image: tugboatqa/php:7.1-apache

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
    image: tugboatqa/mysql

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

## Start Building Previews!

Once this Tugboat configuration file is committed to your git repository, you
can start building previews!
