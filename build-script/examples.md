
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

```
tugboat-init:
    util/tugboat-init.sh

tugboat-build:
    util/tugboat-build.sh

tugboat-update:
    util/tugboat-update.sh
```

## Change an apache document root

```
tugboat-init:
    ln -sf ${TUGBOAT_ROOT}/public_html /var/www/html
```

## Change an nginx document root

```
tugboat-init:
    ln -s ${TUGBOAT_ROOT}/public_html /usr/share/nginx/html
```

## Re-use a common set of commands

```
install:
    npm install
    npm run build

tugboat-init: install
tugboat-update: install
tugboat-build: install
```
