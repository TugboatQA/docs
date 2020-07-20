+++
title = "Leverage Service Commands"
date = 2019-09-19T13:03:56-04:00
lastmod = 2020-07-20T15:00:00-04:00
weight = 3
+++

While technically optional, Service Commands are arguably the most powerful part of the
[configuration file](/setting-up-tugboat/create-a-tugboat-config-file/). This is the set of commands that Tugboat runs
in a Service container while creating a Preview.

Tugboat's service commands fit into two categories:

- [Service commands to run during Preview build](#service-commands-to-run-during-preview-build)
- [Service commands to run after Preview build](#service-commands-to-run-after-preview-build)

## Service commands to run during Preview build

The service commands are separated into a set of stages: `init`, `update`, and `build`. Each stage represents an
optional set of commands that Tugboat should run during that stage. For more info on the stages in the Preview build
process, check out:
[the build process: explained](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained).

It may help to think of the stages as groups of commands with a particular purpose. While not enforced in any way, the
stages roughly represent the following purposes:

- **init** - Run commands that set up the basic Preview infrastructure. This might include things like installing
  required packages or tools, or overriding default configuration files.

- **update** - Run commands that import data or other assets into a Service. This might include things like importing a
  database, or syncing image files into a service.

- **build** - Run commands that build or generate the actual site. This might include things like compiling Sass files,
  updating 3rd party libraries, or running database updates that the current code in the preview depends on.

At any point during the build process, you can use the `ready` command to indicate that a service is "ready" before
proceeding with the build, such as checking for a listening TCP port. However, if you use `ready` to check for something
that doesn't happen until _after_ the command would execute, the Preview can get stuck building indefinitely. For
example, in a Node.js app, you might be tempted to use `ready` to check that port 3,000 is responding, but when the app
is building and the `ready` command would execute the first time, you wouldn't have anything started on port 3,000 yet,
so the Preview will get stuck and the build process will never complete.

{{% notice info %}} Each command is run in its own context, meaning things like `cd` do not "stick" between commands. If
that behavior is required, an external script should be included in the git repository and called from the config file.
{{% /notice %}}

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
    default: true
    commands:
      init:
        - apt-get install nodejs
        - ln -snf "${TUGBOAT_ROOT}" "${DOCROOT}"
      update:
        - rsync -av example.com:files/ "${DOCROOT}/files/"
        - chgrp -R www-data "${DOCROOT}/files"
      build:
        - npm install
  mysql:
    image: tugboatqa/mysql:5.6
    commands:
      update:
        - scp example.com:mysqldump.sql.gz /tmp/
        - zcat /tmp/mysqldump.sql.gz | mysql tugboat
```

Notice that each stage is optional for a given service. There may not be any commands required for that service during
some stage. When that is the case, the stage can be excluded completely.

## Service commands to run after Preview build

You can also configure service commands to run _after_ a Tugboat Preview has built. The three service commands that run
after the build process are:

- **start** - Run commands every time a Preview container starts. This happens any time the container starts; after a
  Preview has [suspended](/building-a-preview/preview-deep-dive/how-previews-work#status-message) or been
  [stopped](/building-a-preview/administer-previews/change-preview-states#start-stop); or if you
  [Reset](/building-a-preview/administer-previews/change-preview-states#reset) the Preview. `start` might be useful for
  [running a background process](../running-a-background-process/); to warm up caches, for example.
- **online** - Run commands once, after a Preview build has completed. These commands only run after the Preview
  snapshot, when a Preview has been through **Build**, **Rebuild** or **Refresh**. For more info on the build process
  and build snapshots, see: [How Previews Work](/building-a-preview/preview-deep-dive/how-previews-work/).
- **clone** - Run commands on the cloned (new) Preview that has been created from another Preview. Commands that you run
  in `clone` get committed as part of the build snapshot, so things like Resetting an image do not erase `clone`
  commands. For more info, see: [How Previews Work](/building-a-preview/preview-deep-dive/how-previews-work/).

For an example of the `online` command, here's a sample code snippet from
[our Diffy integration](/starter-configs/code-snippets/diffy-integration/):

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
    default: true
    commands:
      init:
        # The Diffy CLI tool requires PHP. If the service image does not have PHP
        # installed, do it here
        #- apt-get update
        #- apt-get install php-cli

        # Download the Diffy CLI tool, and authenticate. The latest version can be
        # found at https://github.com/DiffyWebsite/diffy-cli/releases
        - curl -L https://github.com/DiffyWebsite/diffy-cli/releases/download/0.1.2/diffy.phar -o /usr/local/bin/diffy
        - chmod +x /usr/local/bin/diffy
        - diffy auth:login $DIFFY_API_KEY

        # Clean up after apt-get, if it was used
        #- apt-get clean
        #- rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
      online:
        # Compare this service with production
        - diffy project:compare $DIFFY_PROJECT_ID prod custom --env2Url=$TUGBOAT_SERVICE_URL

        # Compare this service with the base preview
        - if [ "x$TUGBOAT_BASE_PREVIEW_URL" != "x" ]; then diffy project:compare $DIFFY_PROJECT_ID custom custom
          --env1Url=$TUGBOAT_BASE_PREVIEW_URL --env2Url=$TUGBOAT_SERVICE_URL; fi
```

The `start` and `clone` commands would run in a similar command context.
