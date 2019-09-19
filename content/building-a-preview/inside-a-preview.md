---
title: "Inside a Preview"
date: 2019-09-19T10:22:08-04:00
weight: 5
---

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
- [Click into Service names to view build logs and output logs for your Services](#click-into-services-to-view-build-and-output-logs)
- [Using the Preview Action inside a Service](#using-the-preview-action-inside-a-service)
- [Start a Terminal in the Service for an on-demand development environment, or to troubleshoot Preview Build failures](#start-a-terminal-in-the-service)

![View Services inside a Preview](../../_images/inside-a-preview-services.png)

### Click into Services to view build and output logs

When you click into the Service name, you're drilling into that Service's
details. You'll see the Service Build Log and Service Output, giving you greater
insight into what's happening within your Services. This can be useful when
you're troubleshooting an issue with a Preview Build.

![Click into Services to view logs](../../_images/inside-a-preview-service-build-and-output-logs.png)

### Using the Preview Action inside a Service

When a Service has an exposed port, you'll see a clickable **Preview** link for
that Service. Clicking the **Preview** link takes you into what that Service is
doing.

The
[`default` service](../../setting-up-services/how-to-set-up-services/index.md#define-a-default-service)
always has an exposed port, so you'll always have the option to Preview that
Service. If that is the only Service that has an exposed port - i.e. it's the
only Service with the **Preview** link - what you'll see is the same as clicking
the blue Preview button.

If you manually
[expose a port](../../setting-up-services/how-to-set-up-services/index.md#expose-a-service-http-port)
in a Service that isn't the `default`, you'll see the Preview option for that
Service, too. Clicking into a **Preview** link for a Service that isn't the
_default_ shows you only what that Service is doing.

![Preview inside a Service](../../_images/inside-a-preview-preview-action.png)

### Start a terminal in the Service

Starting a terminal inside a Service gives you two awesome abilities:

1. [Utilize an on-demand development environment to collaborate with peers](#tugboat-as-an-on-demand-development-environment)
2. [Directly troubleshoot Preview Builds from within their Services](#direct-preview-build-troubleshooting-from-within-a-service)

![Open a terminal into a Service](../../_images/inside-a-preview-open-terminal-into-service.png)

#### Tugboat as an on-demand development environment

Imagine one of your colleagues is working on a new feature, and comes to you for
help because you know more about using `npm`. You don't have the code installed
locally, and it can be a hassle to replicate a colleague's local. Instead, you
can spin up a Tugboat Preview Build that uses your colleague's code, and
terminal directly into `apache` to team up with your colleague - developing
right in the container. Speed up development, and take local configuration
questions out of the equation.

#### Direct Preview Build troubleshooting from within a Service

Isn't it frustrating when a CI build fails, but you don't have a good way to
find out what went wrong? If you're comfortable debugging on the command line,
you can open a terminal directly into your Services to
[troubleshoot](../../troubleshooting/index.md) and test fixes for Tugboat Build
failures.

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

Tugboat-provided images send outbound email through the Tugboat SMTP proxy by
default. If you are using your own image, or your codebase does not use the
underlying operating system mail configuration, use the \$TUGBOAT_SMTP
[Environment Variable](../../setting-up-services/reference-environment-variables/index.md#tugboat-environment-variables)
to ensure that Tugboat is able to properly capture your outbound email.

> #### Warning:: Sending outgoing email from a Preview
>
> Tugboat makes a best-effort attempt at capturing outbound email. Commonly used
> outbound SMTP ports (25, 465, 587, and 2525) are blocked, and any mail sent
> through the Tugboat SMTP proxy is captured for display with the Preview that
> sent it.

## Visual Diffs

When you're using Visual Diffs with your Previews, you'll click into the Preview
to view them. Visual Diffs are a great tool to visualize site changes, and it's
an easy way to spot visual regression.

![Scroll down to view Visual Diffs](../../_images/visual-diffs-scroll-to-view-visual-diffs.png)

For more on Visual Diffs, including how to set them up and use them, see:
[Visual Diffs](../../visual-diffs/index.md).
