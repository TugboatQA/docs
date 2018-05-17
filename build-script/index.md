# Build Script

Tugboat provides a handful of hooks that allow customizations to how it acts at
various points during a preview's life cycle. It does this by providing
environment variables, and by making calls to a Build Script.

The Build Script is a powerful tool. It provides a framework to allow developers
to customize a stock Tugboat Preview environment. For example, a Build Script is
often used to pull in a database or install an uncommon software package, etc.

> #### Info::Save Disk Space
>
> Save a bunch of disk space by cleaning up after apt at the end of the build
> script.
>
> `apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*`

## Makefile

[GNU Make](https://www.gnu.org/software/make/) is how Tugboat provides its
hooks. The following targets can be added to a file named `Makefile` in the root
of a tugboat repository. If a `Makefile` already exists, these can be appended
to it.

Here are the Makefile targets that Tugboat will execute if present.

* **tugboat-init** - This is called when a preview is built from scratch, after
  all of the services have been built, and the git repository has been cloned.
  `tugboat-init` is often used for things like installing libraries or packages
  that are not present in the stock Tugboat containers, or modifying service
  configurations.

* **tugboat-build** - This is called when a Preview is created from a Base
  Preview. The assumption is that things like a database or other assets are
  already present and need to be updated. So, not all of the steps from
  _tugboat-init_ are required.

* **tugboat-update** - This is called when a preview is refreshed, such as
  getting a new database, or rsync-ing files from a production or staging site.
  This action falls somewhere between `tugboat-init` and `tugboat-build`, in
  that there is already data present, and services already configured. They need
  to be updated with fresh data from production or staging.

> #### Info::Naming things is hard
>
> These target names within Tugboat have legacy ties, and are still what they
> are for backward compatibility. We apologize for any confusion that causes.

The use of a `Makefile` or any of the targets listed above is entirely
**optional**. Tugboat will gracefully skip over these steps if the `Makefile`,
or one of the targets does not exist.

All Tugboat services also ship with a
[Helper Makefile](helper-makefile/index.md) to simplify the execution of common
tasks.

Deployments _can_ be done by using the `Makefile` natively, but chances are, you
probably want to
[call out to another script](../examples/features/external-scripts/index.md) or
build tool that does the heavy lifting. This is a very common pattern, as it
lends well to cascading the different build types, and matching the behavior of
deployments on your dev, stage, or production environments.

To learn more, read about the [Helper Makefile](helper-makefile/index.md) or
check out [some example Makefiles](../examples/index.md). You may also want to look
at examples for specific [applications](../examples/applications/index.md) or
[services](../examples/services/index.md).

To learn more about Make syntax:

* http://makefiletutorial.com/
* http://www.gnu.org/software/make/manual/make.html
* https://gist.github.com/isaacs/62a2d1825d04437c6f08

> #### Warning::No Interactive Bash Session
>
> Tugboat Previews are not built with an interactive bash session. This means
> that `.bashrc` or any included files, such as `.bash_aliases`, are not loaded.
> This also means that global environment variables cannot be set inside any
> scripts that run during the build. The only environment variables that are
> globally accessible are those set explicitly by Tugboat.
