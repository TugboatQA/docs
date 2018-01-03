
# Build Script Examples

> **Tip:** Be sure to use tabs. Spaces cause Make to throw errors.

Sometimes it helps to see some examples. Here are some that we have compiled
for various tasks and scenarios.

* [Import a MySQL Database](import_mysql_database.md)
* [Install PHP 7.2](install_php72.md)
* [Change the Document Root Location](change_docroot.md)
* [Re-use a Common Set of Commands](reuse_commands.md)
* [Use External Scripts](external_scripts.md)
* [Run CasperJS Tests](casperjs.md)

## Overview

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

