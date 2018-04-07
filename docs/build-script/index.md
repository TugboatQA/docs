# Build Script

Tugboat provides a handful of hooks that allow customizations to how it acts at
various points during a preview's life cycle. It does this by providing a
number of environment variables, and by making calls to a build script.

The build script is a very powerful tool. It provides a framework to allow
developers to customize a stock Tugboat preview environment in order to make a
site work. For example, pulling a database, or installing an uncommon software
package, etc.

> **Tip** - Save a bunch of disk space by cleaning up after apt at the end of
> the build script.
>
>    `apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*`

## Makefile

[GNU Make](https://www.gnu.org/software/make/) is how Tugboat provides its
hooks. The following targets can be added to a file named `Makefile` in the
root of a tugboat repository. If a `Makefile` already exists, these can be
added to it.

The target names have some legacy ties, and are still what they are for
backwards compatibility. This just means that their use is not exactly
intuitive.

* **tugboat-init** - This is called when a preview is built from scratch, after
  all of the services have been built, and the git repository has been cloned.
  This can be used for things like installing libraries or packages that are
  not present in the stock Tugboat containers, or modifying service
  configurations.

* **tugboat-build** - This is called when a preview is created from a base
  preview. The assumption is that things like a database or other assets are
  already present and just need to be updated. So, not all of the steps from
  _tugboat-init_ are required.

* **tugboat-update** - This is called when a preview is refreshed. This falls
  somewhere between `tugboat-init` and `tugboat-build`, in that there is
  already data present, and services are already configured. They just need to
  be updated

The use of a Makefile, or any of the targets listed above is entirely
**optional**.  Tugboat will gracefully skip over these steps if the Makefile,
or one of the targets does not exist.

Deployments *can* be done by using the Makefile natively, but chances are, you
probably just want to call out to another script that does the heavy lifting.
This is actually a very common pattern, as it lends well to cascading the
different build types.

[Check out some examples](examples/index.md)

## Notes

Tugboat previews are not built with an interactive bash session. This means
that .bashrc or any included files, such as .bash_aliases, are not loaded.
This also means that global environment variables cannot be set inside any
scripts that are run during the build. The only environment variables that are
globally accessible are those set explicitly by Tugboat.
