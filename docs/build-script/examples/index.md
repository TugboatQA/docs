
# Build Script Examples

> **Tip:** Be sure to use tabs. Spaces cause Make to throw errors.

## Overview

Tugboat services ship with a helper Makefile in /usr/share/tugboat that you can
use to install or upgrade certain packages. If you're curious what that gives
you, you can run `make -C /usr/share/tugboat` from any Tugboat service to see
the help text for it, or check out [the source](https://github.com/Lullabot/tugboat-registry/blob/master/baseimage/Makefile)
of this Makefile.

To use the tugboat helper Makefile, you can put this at the top of your
Makefile:

```
-include /usr/share/tugboat/Makefile
```

For example:

[import, lang="makefile"](Makefile)

## Examples

Sometimes it helps to see some examples. Here are some that we have compiled
for various tasks and scenarios.

* [Import a MySQL Database](import-mysql-database/index.md)
* [Install PHP 7.2](install-php72/index.md)
* [Change the Document Root Location](change-docroot/index.md)
* [Re-use a Common Set of Commands](reuse-commands/index.md)
* [Use External Scripts](external-scripts/index.md)
* [Run Functional Tests](functional-tests/index.md)
