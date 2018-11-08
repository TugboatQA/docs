# Start a Background Process

A long-running background process in Tugboat needs some special care. If you try
to add a background-process to your config file in the conventional way, Tugboat
will think the Preview has not finished building, and it will be stuck in the
"building" state until it eventually times out and fails. The reason Tugboat
needs to wait for all of the build commands to finish is that we stop the
services after they finish building in order to take a snapshot.

Our [prebuilt images](../../reference/services/index.md) use
[runit](http://smarden.org/runit/) to start and manage background processes. To
add your own background process that starts when the service starts, create a
directory in `/etc/service/yourprocessname` and a script at
`/etc/service/yourprocessname/run` to tell `runit` how to start your process.

For example, the following `run` script would start Apache:

```
#!/bin/sh
exec httpd-foreground
```

Below is an example of how you might configure a NodeJS process to start. Keep
in mind that `runit` will try to start the process as soon as the `run` script
is present in the service directory. So, set it up after any other build steps
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
