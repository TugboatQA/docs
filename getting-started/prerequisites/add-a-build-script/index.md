# Add a Build Script

Now that you have a Git Repository you'd like Tugboat to clone; you need to tell
Tugboat how to build your project and create Previews. This is done through a
build script.

To get started with your Build Script, create a file named `Makefile` in the
root of your Git Repository.

From here you can either read our
[documentation](../../../build-script/index.md) for Tugboat Build Scripts, or
use a [template](../../../examples/index.md) for one of our
supported stacks.

After you [create an account](../../create-a-tugboat-account/index.md) on
Tugboat and [set up your project](../../create-a-project/index.md), you will
customize your build script. The give you a head start, this is how the process
goes:

* Create a Preview and then debug the output from the logs using the Preview
  detail landing page.
* From the same screen, launch a terminal window into your Preview's webhead and
  edit your Makefile (Build Script) in real-time until you have it working.
* From there, be sure to `git commit` and `git push` your changes back into your
  repository.

![Preview Detail Page](_images/preview-detail-page.png)

* The last step will be to promote this working preview into a
  [Base Preview](../../create-a-base-preview/index.md) to speed up build times
  and significantly reduces the amount of disk space a given preview occupies.
