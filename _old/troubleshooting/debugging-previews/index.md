# Troubleshooting Previews & Base Previews

## Troubleshooting Base Previews

---

### If `master` is my Base Preview and I merge a Pull Request into that, will the Base Preview automatically update?

Yes, Base Previews are automatically updated daily at 12am ET. This frequency
and time of day can be changed in a repository's settings. It can also be
disabled if you prefer to update the base preview manually.

### If my Base Preview is updated, will Previews built from it automatically update with those changes?

No. If a Base Preview is updated, Previews built from it are left alone, and
must be rebuilt manually.

## Troubleshooting Previews

---

### A Preview Fails to Build

Check the Preview logs, and look for an error message. The most common cause of
build failures is the build script exiting with an error.

![Failed Build Logs](_images/failed-log.png)

If you understand the error message, you may have code to fix before you can
rebuild this Preview. If the error message appears to be Tugboat's fault, try
deleting the Preview and building it again. If the problem persists,
[contact support](https://tugboat.qa/support).

### Error: Makefile:x: \*\*\* missing separator. Stop.

If you see an error like this in your Activity Log, you probably have spaces
instead of tabs in your Makefile. Replace the indentation spaces with tabs and
commit your script again.

### My Preview status says "Ready", but my Preview shows a blank screen. How do I fix this?

The Preview status indicates that the Preview built successfully (no errors in
the build script). It doesn't necessarily ensure that your build script is
correct. For example your build script might set up a database but not provide
the correct password to some application config file. In this case the Preview
would build successfully but the application might not load. You can use the
[preview dashboard](../../tugboat-dashboard/previews/index.md) to view
application/web server logs and diagnose any issues.

### Previews are not building automatically

Only Previews from Pull Requests (or Merge Requests) will build automatically.
If they are not, check the repository settings, and make sure "Build Pull
Requests Automatically" option is checked.

Also, make sure that probe frequency is set to something other than "None"

![Pull Request Probe](_images/pr-probe.png)

### How can I warm the cache of my previews?

You can add something like this to the end of your
[build script](../../build-script/index.md)

```sh
curl http://localhost/
```

### How do I inject "secret" data into previews that I don't want to commit to my git repository?

This can be accomplished by using
[custom environment variables](../../build-script/custom-environment-variables/index.md).
