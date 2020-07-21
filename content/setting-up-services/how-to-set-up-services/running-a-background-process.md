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
- [Use the `start` command to start a background process](#use-the-start-command)

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

## Use the start command

If you're not using a Tugboat image that contains `runit` to start a long-running background process, another option is
to use the `start` service command. Commands that you include in `start` in your `.tugboat/config.yml` will run every
time the container starts. You might use this to warm a page cache, for example.

Start works like other
[service commands](/setting-up-services/how-to-set-up-services/leverage-service-commands/#service-commands-to-run-after-preview-build),
so your config might look something like this:

```yaml
services:
  php:
    commands:
      start:
        # Warm the cache
        - sudo -u www-data /var/lib/tugboat/vendor/bin/drush --root /var/lib/tugboat/web warmer:enqueue -l localhost
          --verbose --run-queue
```
