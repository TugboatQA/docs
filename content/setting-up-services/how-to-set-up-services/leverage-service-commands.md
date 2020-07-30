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
- [Additional service commands](#additional-service-commands)

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

You can also configure service commands to run _after_ a Tugboat Preview has built. The two service commands that run
after the build process are:

- **start** - Run commands every time a Preview container starts. This happens any time the container starts; after a
  Preview has [suspended](/building-a-preview/preview-deep-dive/how-previews-work#status-message) or been
  [stopped](/building-a-preview/administer-previews/change-preview-states#start-stop); or if you
  [Reset](/building-a-preview/administer-previews/change-preview-states#reset) the Preview. `start` might be useful for
  [running a background process](../running-a-background-process/); to warm up caches, for example.
- **online** - Run commands once, after a Preview build has completed. These commands only run after the Preview
  snapshot, when a Preview has been through **Build**, **Rebuild** or **Refresh**. For more info on the build process
  and build snapshots, see: [How Previews Work](/building-a-preview/preview-deep-dive/how-previews-work/).

For an example of the `online` and `start` commands, here's a sample code snippet from
[our Diffy integration](/starter-configs/code-snippets/diffy-integration/):

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
    default: true
    commands:
      init:
        # Download the Diffy CLI tool, and authenticate.
        - curl -L https://github.com/DiffyWebsite/diffy-cli/releases/download/0.1.2/diffy.phar -o /usr/local/bin/diffy
        - chmod +x /usr/local/bin/diffy
        - diffy auth:login $DIFFY_API_KEY
      start:
        # Warm the cache
        - sudo -u www-data /var/lib/tugboat/vendor/bin/drush --root /var/lib/tugboat/web warmer:enqueue -l localhost
          --verbose --run-queue
      online:
        # Compare this service with production using Diffy
        - diffy project:compare $DIFFY_PROJECT_ID prod custom --env2Url=$TUGBOAT_SERVICE_URL

        # Compare this service with the base preview
        - if [ "x$TUGBOAT_BASE_PREVIEW_URL" != "x" ]; then diffy project:compare $DIFFY_PROJECT_ID custom custom
          --env1Url=$TUGBOAT_BASE_PREVIEW_URL --env2Url=$TUGBOAT_SERVICE_URL; fi
```

The `start` command would run in a similar command context.

## Additional service commands

In addition to service commands that run during the build process, and service commands that execute after the build
snapshot is complete, there are two more service commands you can use in your Tugboat builds: `clone` and `ready`.

- [Clone](#clone-commands)
- [Ready](#the-ready-command)

### Clone commands

When you use `clone` commands in your config.yml, these commands will only run on the cloned (new) Preview that has been
created from an existing Preview using
[Clone](/building-a-preview/administer-previews/build-previews/#duplicate-a-preview).

Under the covers, Clone duplicates a Preview at the time of
[the build snapshot](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-snapshot). Commands you include
in your `.tugboat/config.yml` as `clone` service commands then run on the duplicated (new) Preview, and then _that_
version of the Preview is committed as a build snapshot, overwriting the original duplicated Preview. As a result,
commands that you run in `clone` get committed as part of the build snapshot, so they become permanently part of the
Preview. Things like [Reset](/building-a-preview/administer-previews/change-preview-states/#reset) do not erase `clone`
commands, and those commands would carry over if you made a Preview cloned in this way a Base Preview.

You might use the `clone` command in cases where your running Previews depend on something written to disk that is
derived from the [Preview ID](/faq/find-tugboat-ids/) or [Service URL](/reference/environment-variables/); or anything
that will have new values in the newly-cloned Preview.

A good use case for the `clone` command would be updating a WordPress database to work with the new URL. From our
[WordPress tutorial](/starter-configs/tutorials/wordpress/), you might execute this on a cloned Preview:

```yaml
clone:
  ## Set the DOCROOT to reflect the new Preview and Service URL
  wp --allow-root --path="${DOCROOT}" search-replace "${TUGBOAT_BASE_PREVIEW_URL_HOST}" "${TUGBOAT_SERVICE_URL_HOST}"
  --skip-columns=guid
```

### The `ready` command

An additional service command you might find useful in some cases is the `ready` command. When you use `ready` as a
[service command](../leverage-service-commands/), you're telling Tugboat to check whether the condition is true, and if
yes, then continue the Preview build. If the condition is not true, `ready` waits and then checks the condition again.

Common use cases for the `ready` command include things like checking whether a port is listening, such as checking for
a `mysql` connection when running `php` services.

The caveat for the `ready` command is that the command you try to execute must be able to pass _before_ the app is
installed, because Tugboat needs to spin up the service prior to the app being installed. So if a `ready` command
depends on the app being installed, Tugboat would be stuck forever checking for a condition that will never pass, and
the build process will eventually time out.

When using `ready` to check for something that doesn't happen until _after_ the command would execute, the Preview will
get stuck building indefinitely. For example, in a Node.js app, you might be tempted to use `ready` to check that port
3,000 is responding, but when the app is building and the `ready` command would execute the first time, you wouldn't
have anything started on port 3,000 yet, so the Preview will get stuck and the build process will never complete.

There are a couple of ways around this; for example, you could add a delay to give extra time for a Node.js app to start
up using something like: `ready: "! test -f ${TUGBOAT_ROOT}/.tugboat/config.yml || sleep 20"`.

Or you could add something like this as an external script:

```
.tugboat/node-ready.sh:
#!/bin/sh set -eu curl \ --silent \ --retry 50 \ --retry-delay 1 \ --retry-connrefused \ --max-time 4 \ --retry-max-time 240 \ localhost:3000 > /dev/null || true
```

Which will try to make a request to `localhost` on port 3000 until there's a response. Then, you could add this line to
your [Tugboat `config.yml`](/setting-up-tugboat/create-a-tugboat-config-file/):

```yaml
ready: - 'test ! -x $TUGBOAT_ROOT/.tugboat/node-ready.sh || $TUGBOAT_ROOT/.tugboat/node-ready.sh'
```

This will make sure the `ready` command passes if the `node-ready.sh` script isn't available yet, and if it _is_
available, it will execute it to see if the Node.js app is running.
