# Troubleshooting

- [A preview fails to build](#a-preview-fails-to-build)
- [A preview says it is "ready", but shows a blank page](#a-preview-says-it-is-ready-but-shows-a-blank-page)
- [Previews are not building automatically](#previews-are-not-building-automatically)

---

## A preview fails to build

Check the preview logs and look for error messages. The most common cause of
build failures is one of the commands in the Tugboat
[configuration file](../configuring-tugboat/index.md) exits with an error. If
that is the case, you may have some code to fix before the preview can be
rebuilt

![Failed Preview Log](_images/failed-log.png)

Sometimes it is tricky to tell whether the problem is in your code or if Tugboat
failed in some way that is beyond your control. If you can't tell, we are happy
to look into the problem with you to see whether we can help. Just
[let us know](https://tugboat.qa/support).

## A preview says it is "ready", but shows a blank page

When a preview says it is "ready", that means that it successfully ran the
commands in your configuration, and none of those commands returned an error. It
does not necessarily mean that those commands did what you expected them to do.
For example, your configuration might set up a database but not provide the
correct password to some application config file. In this case the preview would
build successfully but the application might not load.

Double-check the commands in the configuration file, check the preview's logs
for any clues, and make use of Tugboat's terminal access to the preview to do
the same type of troubleshooting you would do if this happened on your local
installation.

## Previews are not building automatically

Only previews for pull requests are built automatically. If they are not being
built, check the repository settings, and make sure "Build Pull Requests
Automatically" is enabled.

![Build Pull Requests Automatically](_images/pr-probe.png)
