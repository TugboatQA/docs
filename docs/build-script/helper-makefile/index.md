# Helper Makefile

All Tugboat services ship with a helper Makefile in `/usr/share/tugboat` that
you can use to install or upgrade certain packages. If you're curious what that
gives you, you can run `make -C /usr/share/tugboat _help` from any Tugboat
service to see the help text for it, or check out [the
source](https://github.com/Lullabot/tugboat-registry/blob/master/baseimage/Makefile)
of this Makefile.

To use the tugboat helper Makefile, you can put this at the top of your
Makefile:

```
-include /usr/share/tugboat/Makefile
```

Make sure to keep the hyphen at the beginning of the include if you want your
Makefile to work on non-Tugboat environments.

Alternately, you can call '$(MAKE) -C /usr/share/tugboat foo' from within a
target if you don't want to include this Makefile in its entirety:

[import:15-18, lang:'makefile', template:'ace'](Makefile)

Once you've added it, you can use these targets:

- `_help`: Print out the help for the Helper Makefile include.
- `_targets`: Print out the available targets in the Helper Makefile include.
- `install-composer`: Installs the latest version of Composer.
- `install-drush-launcher`: Installs the [drush-launcher](https://github.com/drush-ops/drush-launcher) instead of drush.
- `install-drush`: Installs the latest version of [drush](https://www.drush.org).
- `install-nodejs-%`: Install a specific version of nodejs by replacing the %, e.g. install-nodejs-8.
- `install-package-%`: Install a specific package on this distro by replacing %, e.g. install-package-wget.
- `install-php-%`: Install a specific version of PHP by replacing the %, e.g. install-php-7.2.
- `install-terminus`: Install terminus for Pantheon sites.
- `packages-update`: Gets information on the newest versions of packages and their dependencies.

For more targets and info see the comments in the [Makefile source](https://github.com/Lullabot/tugboat-registry/blob/master/baseimage/Makefile).

For example:

[import, lang="makefile"](Makefile)
