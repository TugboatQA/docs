# Glossary

Tugboat terms and definitions.

## Access Tokens

[Personal access tokens](../../features/access-tokens/index.md) are used in
place of your password when accessing Tugboat through the
[Command Line Tool](../../features/cli/index.md) or
[Tugboat API](../../reference/api/index.md). You generate a token from your
Tugboat account, then copy and paste it to the terminal window or script.

## Base Preview

A Base Preview is a starting point from which other Previews are built. Its
primary purposes are to speed up the build time and reduce the amount of disk
space required by a Preview. As an example, if you have a large set of test data
which you wish to load you could see a substantial speedup in build times by
creating a Base Preview in which that data is already loaded. When a new Preview
is built, it will start with the Base Preview and run the `tugboat-update`
target (rather than `tugboat-init`). See
[tugboat-update](../../build-script/index.md#makefile) in the build script
documentation for more information.

## Build Script

A build script is how you customize your Tugboat Preview. Previews start as a
bare-bones Linux installation and a copy of your repository code. Anything you
might do to get a local development environment up and running is likely
something which should be in your build script. This might include things like
installing dependencies for your application, creating/updating application
configuration files, populating a database with test data, etc. For more
information see the [build script](../../build-script/index.md) section of this
documentation.

## CLI

The Tugboat [Command Line Interface](../../features/cli/index.md) provides local
access to your Tugboat account. It allows you to perform all of the operations
available through the web interface. It also provides access to the more
advanced features of Tugboat.

## Makefile

A makefile is a special file, containing shell commands, that you create and
name `Makefile`. In Tugboat we use a Makefile as
[build script](../../build-script/index.md) for your project.

## Preview

A Preview is a build artifact generated from a Git Branch, Tag or Pull Request.
Tugboat builds Preview environments for your website so you can see what new
code looks like before it's merged into production.

## Repository

A repository is a place where your project lives in Git and contains the history
of your work. Tugboat clones your repository so it can build Previews of that
work. Within a repository you have branches, which are effectively forks within
your repository. You can later merge your branch changes. Branches let you work
on multiple parts of your project at once.

# Terminus

A command-line tool for interacting with a
[Pantheon](https://pantheon.io)-hosted site.

## Webhead

Usually, Apache or Nginx serve as the webhead for your project. These services
(web servers, in this case) store the files in your git repository you wish to
serve through a web browser and publish a website.
