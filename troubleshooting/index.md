# Troubleshooting Tugboat

This guide is an initial set of troubleshooting steps to take if you are having problems getting Tugboat to build your Previews. We assume you've already gone through the five steps in the [Getting Started](/getting-started/) section. 

For problems specific to your build script see our [debugging guide](/troubleshooting/build-script-debug/). For issues related to Previews, take a look at our [common problems and solutions to Previews](/troubleshooting/debugging-previews/). 

---

## How do I build my first preview?
See our [getting started](/getting-started/index.md) guide for a walkthrough which includes getting [your first preview](/getting-started/create-a-preview/index.md) up and running.

## How do I add my database?
A database can be added to your previews by adding it as a service in the repository settings page. Data can be imported as part of the [build script](/build-script/index.md). If the data resides on a remote server (e.g. not in your repository) each Tugboat repository has a generated SSH key visible in the repository settings. This key can be added to the remote server allowing your Tugboat build script to log in without a password and run whatever command may be necessary to dump/import your data into the database server your preview will connect to. For an example see the [MySQL import example](/build-script/example-build-scripts/snippets/import-mysql-database/).

## Can I have SSH access?
No, direct SSH access to Previews is not possible. However, shell access is provided to running Previews via our web-based Tugboat SHell (TuSH) found on the [preview's dashboard](/tugboat-dashboard/previews/index.md).

---

## Repositories & Projects

### How do I add a repository?
There are a few locations where you can add a repository to your Tugboat Project. A repository can be added when you create a new project or added to an existing project by clicking on the 'Add a repository' link on the dashboard of your project.
 
See our [getting started](/getting-started/index.md) guide for additional information.

### Is there a limit to the number of repositories I can have?
There is no hard limit on the number of repositories a project can contain; however, you are limited to overall disk usage. And resource quotas such as disk space are tracked per project, so this will impact the number of Previews which can be active at a given time.

### What is the difference between a Project and a Repository?
A project is the "top level" concept in Tugboat. Users, Repositories, and Previews belong to specific projects. A Repository is a mapping to a git repository and is the source from which Previews are made.

### How do I know if I should add a Repository to my Project or start a new Project?
The choice is entirely yours to make, a project may have any number of repositories but keep in mind that disk space quotas are on the Project level, this means that more repositories might create more Previews and use more disk space. It also may make sense to create multiple projects to organize repositories into logical groups better.

### What can project admins do that invited users can't?
Project admins can add new repositories, manage project users and make billing/account tier changes.

### How many users can I invite?
There is no limit to the number of users you can invite to your project.
