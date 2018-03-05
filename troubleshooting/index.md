# Troubleshooting

## A Preview Fails to Build

Check the preview logs, and look for an error message. The most common cause
of build failures is the build script exiting with an error.

![Failed Build Logs](_images/failed-log.png)

If you understand the error message, you may have code to fix before you can
rebuild this preview. If the error message appears to be Tugboat's fault, try
deleting the preview and building it again. If the problem persists,
[contact support](https://tugboat.qa/support).

## Previews are not building automatically

Only pull request previews will build automatically. If they are not, check the
repository settings, and make sure "Build Pull Requests Automatically" is checked.

Make sure that probe frequency is set to something other than "None"

![Pull Request Probe](_images/pr-probe.png)

## Error: Makefile:x: *** missing separator.  Stop.

If you see an error like this in your Activity Log, you probably have spaces instead of tabs in your Makefile. Replace the indentation spaces with tabs and commit your script again. 
