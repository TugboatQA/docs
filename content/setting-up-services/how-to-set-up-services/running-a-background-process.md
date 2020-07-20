+++
title = "Running a Background Process"
date = 2019-09-19T13:05:11-04:00
lastmod = 2020-07-20T15:00:00-04:00
weight = 8
+++

A long-running background process in Tugboat needs some special care. If you try to add a background-process to your
[config file](/setting-up-tugboat/create-a-tugboat-config-file/) in the conventional way, Tugboat will think the Preview
has not finished building, and it will be stuck in the "building" state until it eventually times out and fails.

{{% notice info %}} The reason Tugboat needs to wait for all of the `build` commands to finish is that we stop the
Services after a Preview build is finished in order to take a snapshot. {{% /notice %}}

You can use two techniques to run a background process:

- [Use a Tugboat image that contains `runit` to start a build script independent of the Preview build process.](#use-runit-in-an-official-tugboat-image)
- [Use the `ready` command to indicate a service is "ready."](#use-the-ready-command)

## Use runit in an official Tugboat image

Our [prebuilt images](../../service-images/using-tugboat-images/) use [runit](http://smarden.org/runit/) to start and
manage background processes.

To add your own background process that starts when the Service starts, create a directory in
`/etc/service/yourprocessname` and a script at `/etc/service/yourprocessname/run` to tell `runit` how to start your
process.

For example, the following `run` script would start Apache:

```
#!/bin/sh
exec httpd-foreground
```

Below is an example of how you might configure a NodeJS process to start. Keep in mind that `runit` will try to start
the process as soon as the `run` script is present in the Service directory. So, set it up after any other build steps
that it might depend on.

```yaml
services:
  node:
    image: tugboatqa/node:8
      commands:
        init:
          - mkdir -p /etc/service/node
          - echo "#!/bin/sh" > /etc/service/node/run
          - echo "npm start --prefix ${TUGBOAT_ROOT}" >> /etc/service/node/run
          - chmod +x /etc/service/node/run
```

## Use the ready command

If you're using your own custom image that does not include `runit`, or you have other use cases for running a
background process, you can use the `ready` command. When you use `ready` as a
[service command](../leverage-service-commands/), you're telling Tugboat to check whether the condition is true, and if
yes, then continue the Preview build. If the condition is not true, `ready` waits and then checks the condition again.

Common use cases for the `ready` command include things like checking whether a port is listening, such as checking for
a `mysql` connection when running `php` services.

The caveat for the `ready` command is that the command you try to execute must be able to pass _before_ the app is
installed, because Tugboat needs to spin up the service prior to the app being installed. So if a `ready` command
depends on the app being installed, Tugboat would be stuck forever checking for a condition that will never pass, and
the build process will eventually time out.

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
