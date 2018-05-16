# FAQ

## What technologies can we use with Tugboat?

Tugboat supports pretty much anything that runs on linux. Here is a list of our
current containers, but if you have a tech stack that needs more, we can add it.
Just let us know. https://github.com/Lullabot/tugboat-registry

## What kinds of CMSes work with Tugboat?

We've mainly been using Drupal as the CMS of choice, but Tugboat is platform
agnostic. As long as your software can be built and run on linux, Tugboat can
handle it.

## Will Tugboat work with Acquia Cloud?

Yes. We've used Tugboat for projects that run on Acquia cloud many times. While
Tugboat itself runs on Linode servers, Your production code and database can
still live on the Acquia Cloud servers.

## How can I warm the cache of my previews?

You can add something like this to the end of your [build
script](/build-script/index.md)

```sh
curl http://localhost/
```

## A preview is failing. What can I do?

See [Troubleshooting](/troubleshooting/index.md).

## How does Tugboat deal with email?

Tugboat makes a best effort to capture outbound email. Using the local
`sendmail` or the SMTP server at `$TUGBOAT_SMTP` will result in email being
captured by Tugboat. These captured emails are only saved for as long as the
preview that sent them exists.

Tugboat does not attempt to capture any other outbound SMTP server connections,
so if you are concerned with sending emails to customers from a QA environment,
be sure to update your application configuration to use Tugboat's SMTP server.

## How do I add a repository?

There are a few places in which you can add a repository to your Tugboat
Project. A repository can be added when you create a new project or added to an
existing project by clicking on the 'Add a repository' link on the dashboard of
your project.
 
See our [getting started](/getting-started/index.md) guide for additional
information.

## How do I add my database?

A database can be added to your previews by adding it as a service in the
repository settings page. Data can be imported as part of the [build
script](/build-script/index.md). If the data resides on a remote server (e.g.
not in your repository) each Tugboat repository has a generated SSH key visible
in the repository settings. This key can be added to the remote server allowing
your Tugboat build script to log in without a password and run whatever command
may be necessary to dump/import your data into the database server your preview
will connect to. For an example see the [MySQL import
example](/build-script/examples/import-mysql-database/index.md).

## What is a Base Preview?

A base preview is a starting point from which other previews are built. It's
primary purposes are to speed up the build time and reduce the amount of disk
space required by a preview. As an example if you have a large set of test data
which you wish to load you could see a substantial speed up in build times by
creating a base preview in which that data is already loaded. When a new preview
is built, it will start with the base preview and run the tugboat-update target
(rather than tugboat-init). See
[tugboat-update](/build-script/index.md/#makefile) in the build script
documentation for more information.

## What is a build script?

A build script is how you customize your Tugboat preview. Previews start as a
bare bones Linux installation and a copy of your repository code. Anything you
might do to get a local development environment up and running is likely
something which should be in your build script. This might include things like
installing dependencies for your application, creating/updating application
configuration files, populating a database with test data, etc. For more
information see the [build script](/build-script/index.md) section of this
documentation.

## How do I build my first preview?

See our [getting started](/getting-started/index.md) guide for a walkthrough
which includes getting [your first
preview](/getting-started/create-a-preview/index.md) up and running.

## Is there a limit to the number of repositories I can have?

There is no hard limit on the number of repositories a project can contain,
however resource quotas such as disk space are tracked per project so this will
impact the number of previews which can be active at a given time.

## How many users can I invite?

There is no limit to the number of users you can invite to your project.

## What can project admins do that invited users can't?

Project admins can add new repositories, manage project users and make
billing/account tier changes.

## Can I have SSH access?

No, direct SSH access to previews is not possible. However shell access is
provided to running previews via our web based Tugboat SHell (TuSH) found on the
[preview's dashboard](/tugboat-dashboard/previews/index.md).

## Do you provide production level hosting?

No, Tugboat containers are intended to be (relatively) short lived, and don't
come with the sort of stability/support guarantees needed to host a production
application. It is also against our [Terms of
Service](https://tugboat.qa/terms).

## If master is my Base Preview and I merge a Pull Request into that, will the Base Preview automatically update?

Yes, Base Previews are automatically updated daily at 12am ET. This frequency
and time of day can be changed in a repository's settings. It can also be
disabled if you prefer to update the base preview manually.

## If my base preview is updated, will previews built from it automatically update with those changes?

Currently, no. If a base preview is updated, previews built from it are left
alone, and must be rebuilt manually.

## I don't see a Service for X. Do you support it?

We are adding new services all the time, feel free to [contact
us](https://tugboat.qa/support) if there's something new you would like to see
supported. For more advanced users it is possible to install any service you
might require in the same container as your application this would require
installing and configuring it yourself however. See
[examples](/build-script/examples/index.md) in the build script documentation.

## Which Linux distributions does Tugboat support?

Our containers are currently built on Ubuntu (14.04).

## Do you support Windows?

Unfortunately no, at this time we do not support windows.

## Which repository providers do you support?

Currently GitHub, Bitbucket and GitLab are supported. Self hosted git
repositories are available as an option for self hosted [Tugboat for
Enterprise](https://tugboat.qa/enterprise). Is there a provider you'd like to
see added? [Contact us](https://tugboat.qa/support) and we will look into it.

## Do you support self hosted git repositories?

Self hosted git repositories are available as an option for self hosted [Tugboat
for Enterprise](https://tugboat.qa/enterprise).

## My Preview status says "Ready", but my Preview shows a blank screen. How do I fix this?

The preview status indicates that the preview built successfully (no errors in
the build script). It doesn't necessarily ensure that your build script is
correct. For example your build script might set up a database but not provide
the correct password to some application config file. In this case the preview
would build successfully but the application might not load. You can use the
[preview dashboard](/tugboat-dashboard/previews/index.md) to view
application/web server logs and diagnose any issues.

## What is the difference between a Project and a Repository?

A project is the "top level" concept in Tugboat. Users, Repositories, and
Previews belong to specific projects. A Repository is a mapping to a git
repository and is the source from which Previews are made.

## How do I know if I should add a Repository to my Project or start a new Project?

The choice is entirely yours to make, a project may have any number of
repositories but keep in mind that disk space quotas are on the Project level,
this means that more repositories might create more previews and use more disk
space. It also may make sense to create multiple projects to better organize
repositories into logical groups.

## How do I inject "secret" data into previews that I don't want to commit to my git repository?

This can be accomplished by using [custom environment variables](../../build-script/custom-environment-variables/index.md).