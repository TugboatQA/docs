---
title: "Create a Tugboat Config File"
date: 2019-09-17T11:42:29-04:00
weight: 5
---

The final step in setting up your Tugboat is creating a Tugboat config. This config is Tugboat's infrastructure-as-code
implementation for specifying the instructions required to build working Previews of your website. There are two ways to
pass config information to Tugboat:

- Commit a Tugboat config.yml file to a linked git repository
- Pass a Tugboat config JSON object to the API as a parameter on Preview creation

## Committing a Tugboat config.yml file

The traditional way to create a Tugboat config is to commit a YAML Config file in the linked git repository.

The Tugboat Config file should live at `.tugboat/config.yml` in the branch, tag, commit or pull request that is being
built.

## Passing a Tugboat config as a parameter

The other way to manage your Tugboat config is to pass it to the [Tugboat API](https://api.tugboat.qa/) as a parameter
when building Previews using the API. This option is available
[on POST when creating Previews](https://api.tugboat.qa/v3#tag/Previews/paths/~1previews/post).

## What's in the config.yml file?

The config file defines the Services that your Tugboat Preview will set up during the build process, as well as any
Service commands you'll use to provide instructions at specific points in the build process.

Start with these docs to begin creating a `config.yml` for your Previews:

- [Setting up Services in your Tugboat](/setting-up-services/)
- [Starter Configuration files](/starter-configs/) (configuration file code snippets with comments to help you get
  started)

You may also find these docs helpful if you want to do things like use the Tugboat CLI to build Previews, shell into
services, or debug your Tugboat config:

- [Using the Tugboat Command Line Tool](/tugboat-cli/)
- [Tugboat Configuration Reference](/reference/tugboat-configuration/) (detailing the attributes you can use when
  building Previews with Tugboat)
- [Debugging Config files](/troubleshooting/debug-config-file/)
