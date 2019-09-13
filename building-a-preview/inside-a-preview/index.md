# Inside a Preview

When you click into a Preview, you'll find a few different things:

- [Services and their logs](#services)
- [Preview log](#preview-log)
- [Captured mail](#captured-mail)
- [Visual Diffs](#visual-diffs)

## Services

One of the first things you'll see inside a Preview is a list of all Services
running in that Preview, as well as information about each of these services.
From here, you can:

- Determine which Service is the
  [Default Service](../../setting-up-services/how-to-set-up-services/index.md#define-a-default-service)
- Click into Service names to view build logs and output logs for your Services
- Start a Terminal in the Service

[MATT AND BEN - I have waffled over whether we should build out each of these
items into a subsection with more info/a set of steps - i.e. "To view build logs
and output logs for your Services". I feel a single screenshot with callouts to
these elements should be sufficient for users who have gotten to this point, but
listing it all out with steps would be more consistent with other parts of this
section. Thoughts?]

![View Services inside a Preview](../../_images/inside-a-preview-services.png)

If you're having problems with a Preview, you may need to spend some time in a
Preview's Services for [troubleshooting](../../troubleshooting/index.md).

## Preview log

In the Preview log section, you'll see a build log for your Preview build. The
Preview Log pane may not show the entirety of the log; if you've got a complex
build, you may need to click **See Full Log** to find and diagnose something
early in your Preview build.

![View the Preview Log](../../_images/inside-a-preview-log.png)

These logs differ from the Service logs in that these logs reflect _all_ the
commands in your Preview build, while the Service logs dive deep into the build
and output of Services but each log details only that Service. When using the
logs for troubleshooting, you may want to start with the Preview log to
determine where something went wrong, and then you may dive into that Service's
log to dig deeper.

## Captured mail

If you're using a Tugboat-provided image, outgoing email generated within your
Preview should forward to our SMTP proxy. Tugboat captures that outgoing email,
and displays it in Captured Mail when you click into a Preview. This makes it
possible for you to verify that email is sending as expected.

> #### Note:: Sending outgoing email from your own image
>
> When you use a non-Tugboat-provided image, outgoing email generated from
> within a Preview may actually leave the Preview.

## Visual Diffs

When you're using Visual Diffs with your Previews, you'll click into the Preview
to view them. Visual Diffs are a great tool to visualize site changes, and it's
an easy way to spot visual regression.

![Scroll down to view Visual Diffs](../../_images/visual-diffs-scroll-to-view-visual-diffs.png)

For more on Visual Diffs, including how to set them up and use them, see:
[Visual Diffs](../../visual-diffs/index.md).
