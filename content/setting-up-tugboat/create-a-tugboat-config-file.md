---
title: "Create a Tugboat Config File"
date: 2019-09-17T11:42:29-04:00
weight: 5
---

The final step in setting up your Tugboat is committing a YAML Config file in the source's git repository. Think of the
Config file as the engine that powers Tugboat; here's where you specify the Services you want to run when your Tugboat
Preview builds.

The Tugboat Config file should live at: `.tugboat/config.yml` in the branch, tag, commit or pull request that is being
built.

Creating the Config file can be a complex process, like building a Tugboat's engine from parts! These docs can help get
you started:

- [Setting up Services in your Tugboat](/setting-up-services/)
- [Starter Configuration files](/starter-configs/) (configuration file code snippets with comments to help you get
  started)
- [Using the Tugboat Command Line Tool](/tugboat-cli/)
- [Tugboat Configuration](/reference/tugboat-configuration/) (detailing the attributes you can use when building
  Previews with Tugboat)
- [Debugging Config files](/troubleshooting/debug-config-file/)
