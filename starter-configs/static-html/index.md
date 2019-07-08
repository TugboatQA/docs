# Static HTML

A static HTML Tugboat Preview serves files exactly as they are found in the git
repository.

## Configure Tugboat

The Tugboat configuration is managed by a
[YAML file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file) at
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

## Start Building Previews!

Once this Tugboat configuration file is committed to your git repository, you
can start [building previews](../../building-a-preview/index.md)!
