---
title: "Create a Tugboat Config File"
date: 2019-09-17T11:42:29-04:00
weight: 5
---

The final step in setting up your Tugboat is committing a YAML Config file in
the source's git repository. Think of the Config file as the engine that powers
Tugboat; here's where you specify the Services you want to run when your Tugboat
Preview builds.

The Tugboat Config file should live at: `.tugboat/config.yml` in the branch,
tag, commit or pull request that is being built.

Creating the Config file can be a complex process, like building a Tugboat's
engine from parts! These docs can help get you started:

- [Setting up Services in your Tugboat](../../setting-up-services/)
- [Starter Configuration files](../starter-configs/index.md) (configuration file
  code snippets with comments to help you get started)
- [Using the Tugboat Command Line Tool](../tugboat-cli/index.md)
- [Service Attributes](../../setting-up-services/reference-service-attributes/)
  (detailing the attributes you can use when building
- [Debugging Config files](../troubleshooting/index.md#debugging-config-files)

#### Jump Link Example
- [Adding a link to a Git Provider](../connect-with-your-provider/#adding-a-link-to-a-git-provider)
