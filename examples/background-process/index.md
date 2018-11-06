# Adding a Background Process

A long-running process in Tugboat needs some special care. If you try to add a
background-process to your config file in the conventional way, Tugboat will
think the Preview hasn't finished your build will become stuck in the "building"
phase. This is because we stop the services long enough to take a snapshot of it
so it can be promoted to a [Base Preview](../../concepts/base-previews/).

If you're using our [images](../../reference/services/), we use
[`runit`](http://smarden.org/runit/) to act as a process watcher. When a new
service was configured, `runit` will see it and start it up when needed.

To have a process start, and stay running, create a directory in
`/etc/service/*yourprocessname*` and a startup script at
`/etc/service/*yourprocessname*/run` that starts your process after the snapshot
is taken.

For example, we use
[this script](https://github.com/TugboatQA/images/blob/master/services/httpd/run)
to start Apache in our own images:

```
#!/bin/sh
exec httpd-foreground
```

A more complicated example is below. Placing this script in your config file
will start `npm` as a background process and then add logging to the service.
You will most likely need to configure the `npm` `--prefix` argument to point to
a specifc folder inside your `$TUGBOAT_ROOT` before you use it. Here is a link
to the
[full config file](https://github.com/TugboatQA/Contenta-CMS-Starter-Kit/blob/0af9f1867fde0720e0cc7dbac4007e6590f8811b/.tugboat/config.yml#L15-L26)
for context.

```
# Make a runit script to automatically run 'npm start'
- mkdir -p /etc/service/npm && touch /etc/service/npm/run
- echo -e "#!/bin/sh\nexec npm start --prefix ${TUGBOAT_ROOT}" >> "/etc/service/npm/run"
- echo -e "exec svlogd -t /var/log/npm" >> "/etc/service/npm/run"
- chmod a+x /etc/service/npm/run
# Make a logging service
- mkdir -p /var/log/npm
- mkdir -p /etc/service/npm/log
- touch /etc/service/npm/log/run
- chmod a+x /etc/service/npm/log/run
- echo "#!/bin/sh" >> /etc/service/npm/log/run
- echo "exec svlogd -t /var/log/npm" >> /etc/service/npm/log/run
```
