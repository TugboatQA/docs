# Static HTML

A static HTML site serves files exactly as they are found in the git repository.

## Configure Tugboat

The Tugboat configuration is managed by a YAML file at `.tugboat/config.yml` in
the git repository. Below is a basic static HTML configuration with comments to
explain what is going on. Use it as a starting point, and customize it as needed
for your own installation.

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

## Start Building Previews!

Once this Tugboat configuration file is committed to your git repository, you
can start building previews!
