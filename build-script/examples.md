
# Build Script Examples

> **Tip:** Be sure to use tabs. Spaces cause Make to throw errors.

## Pseudocode

```
# Build a preview from scratch
tugboat-init:
    # install packages
    # configure services
    # get the container(s) ready for your application
    # call tugboat-update

# Update an existing preview
tugboat-update:
    # pull in fresh data, if applicable
    # call tugboat-build

# Start from a base preview
tugboat-build:
    # run application-specific script(s)
    # compile, uglify, etc.
```

## Call out to external scripts

```makefile
tugboat-init:
    util/tugboat-init.sh

tugboat-build:
    util/tugboat-build.sh

tugboat-update:
    util/tugboat-update.sh
```

