---
title: "Preview Won't Build"
date: 2019-09-19T12:38:29-04:00
lastmod: 2020-07-20T15:00:00-04:00
weight: 1
---

- [My Preview Build is stuck at...](#my-preview-build-is-stuck-at)
- [Troubleshooting a Preview Build failure](#troubleshooting-a-preview-build-failure)
- [Previews are not Building automatically](#previews-are-not-building-automatically)

## My Preview Build is stuck at...

Uh oh! Did your Preview Build get stuck?

- [Pending](#pending)
- [Building](#building)
- [Rebuilding](#rebuilding)
- [Refreshing](#refreshing)
- [Canceling](#canceling)

### Pending

Your Preview Builds/Rebuilds/Refreshes appear as `Pending` when Tugboat is waiting for an available slot in the build
queue. If you {{% ui-text %}}Cancel {{% /ui-text %}} and then retry the process, most of the time, your Preview loses
its spot in line and goes back to the end of the queue.

Give it some time, and if you're still having issues, contact us at [Help and Support](/support/).

### Building

Has your Preview been building for a long time? There are a couple of things to check:

Take a look at your Repository Stats to see how long your average build time is. If your Preview has been building for
less than that time, hang in there; if it has been in `building` for significantly longer, it might be time to
troubleshoot.

![View average build time in Repository Stats](/_images/repo-stats-build-time.png)

When you're ready to troubleshoot, start by taking a
[look at the Preview's logs](../debug-config-file/#how-to-check-the-preview-logs). Logs should give you some insight
into where the Preview is in the build process. If you see that the Preview build isn't progressing, checking out where
it got stuck is a great place to start [debugging the Config file](../debug-config-file/) and figuring out what's
causing the Preview build to hang.

{{% notice tip %}} If your build is getting "stuck" and you're trying to run a background process, there may be an issue
with the command you're trying to execute not being possible until the app has built. Take a look at
[running a background process](/setting-up-services/how-to-set-up-services/running-a-background-process/), and feel free
to reach out at [Help and Support](/support/) if you can't figure out where it's hanging. {{% /notice %}}

If your builds are taking longer than expected, but there isn't an issue in your config file causing problems, take a
look at [Optimize your Preview builds](/building-a-preview/preview-deep-dive/optimize-preview-builds/) for a few things
you might try:

- [Use Service Commands to create a Base Preview that does the heavy lifting](/building-a-preview/preview-deep-dive/optimize-preview-builds/#use-service-commands-to-create-a-base-preview-that-does-the-heavy-lifting)
- [Use the Auto Refresh Base Preview functionality to update large assets](/building-a-preview/preview-deep-dive/optimize-preview-builds/#use-the-auto-refresh-base-preview-functionality-to-update-large-assets)
- [Optimize Preview size](/building-a-preview/preview-deep-dive/optimize-preview-builds/#optimizing-preview-size)
- [Contact Tugboat support for help optimizing your Config file](/building-a-preview/preview-deep-dive/optimize-preview-builds/#contact-tugboat-support-for-help-optimizing-your-config-file)
- [Upgrade your project tier to a higher-performance tier](/building-a-preview/preview-deep-dive/optimize-preview-builds/#upgrade-your-project-tier-to-a-higher-performance-tier)

### Rebuilding

Preview hung on `rebuilding`? Take a look at your Repository Stats to see how long your average build time is. If your
Preview has been building for less than that time, hang in there; if it has been in `rebuilding` for significantly
longer, it might be time to troubleshoot.

![View average build time in Repository Stats](/_images/repo-stats-build-time.png)

When you're ready to troubleshoot, start by taking a
[look at the Preview's logs](../debug-config-file/#how-to-check-the-preview-logs). Logs should give you some insight
into where the Preview is in the rebuild process. If you see that the Preview build isn't progressing, checking out
where it got stuck is a great place to start [debugging the Config file](../debug-config-file/) and figuring out what's
causing the Preview rebuild to hang.

{{% notice tip %}} If you're rebuilding a Preview that was generated without a Base Preview, the rebuild process starts
with the commands in `init`. If you're rebuilding a Preview that was generated from a Base Preview, rebuild starts with
the commands in `build`. Which type of Rebuild you're doing should tell you where you start looking for problems in the
config file - during `init` or skipping straight to `build` commands. For more info, see:
[The build process: explained](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained).
{{% /notice %}}

If your rebuilds are taking longer than expected, but there isn't an issue in your config file causing problems, take a
look at [Optimize your Preview builds](/building-a-preview/preview-deep-dive/optimize-preview-builds/) for a few things
you might try:

- [Use Service Commands to create a Base Preview that does the heavy lifting](/building-a-preview/preview-deep-dive/optimize-preview-builds/#use-service-commands-to-create-a-base-preview-that-does-the-heavy-lifting)
- [Use the Auto Refresh Base Preview functionality to update large assets](/building-a-preview/preview-deep-dive/optimize-preview-builds/#use-the-auto-refresh-base-preview-functionality-to-update-large-assets)
- [Optimizing Preview size](/building-a-preview/preview-deep-dive/optimize-preview-builds/#optimizing-preview-size)
- [Contact Tugboat support for help optimizing your Config file](/building-a-preview/preview-deep-dive/optimize-preview-builds/#contact-tugboat-support-for-help-optimizing-your-config-file)
- [Upgrade your project tier to a higher-performance tier](/building-a-preview/preview-deep-dive/optimize-preview-builds/#upgrade-your-project-tier-to-a-higher-performance-tier)

### Refreshing

Preview hung on `refreshing`? Take a look at your Repository Stats to see how long your average build time is. If your
Preview has been refreshing for less than that time, hang in there; if it has been in `refreshing` for significantly
longer, it might be time to troubleshoot.

![View average build time in Repository Stats](/_images/repo-stats-build-time.png)

When you're ready to troubleshoot, start by taking a
[look at the Preview's logs](../debug-config-file/#how-to-check-the-preview-logs). Logs should give you some insight
into where the Preview is in the refresh process. If you see that the Preview refresh isn't progressing, checking out
where it got stuck is a great place to start [debugging the Config file](../debug-config-file/) and figuring out what's
causing the Preview rebuild to hang.

### Canceling

If you've decided to cancel a Preview Action, but the Preview is stuck on `canceling`, there are a couple of things you
can try:

1. Hang in and wait a bit longer.
2. Force-delete a stuck Preview from the [Tugboat CLI](/tugboat-cli/).
3. If you're still having issues, contact us at [Help and Support](/support/).

## Troubleshooting a Preview Build Failure

If your Tugboat Preview has `failed` to build, it's time to take a
[look at the Preview logs](../debug-config-file/#how-to-check-the-preview-logs). The most common cause of build failures
is when one of the commands in the Tugboat [configuration file](/setting-up-tugboat/create-a-tugboat-config-file/) exits
with an error. If that is the case, it's time to start [debugging the configuration file](../debug-config-file/).

![Failed Preview Log](/_images/failed-log.png)

If you're having problems figuring out why the Preview build `failed`, we're happy to look into the problem with you to
see whether we can help. We've gotten good at spotting common config file issues, and we're happy to help.
[Let us know](https://www.tugboatqa.com/support).

## Previews are not building automatically

Are you expecting a Preview to build automatically? Only Previews for pull requests are built automatically. If Previews
are not being built from your PRs, check the [Repository Settings](/setting-up-tugboat/select-repo-settings/), and make
sure "Build Pull Requests Automatically" is enabled.

![Build Pull Requests Automatically](/_images/pr-probe.png)

{{% notice tip %}} The option to "Build Pull Requests Automatically" only appears if you have linked your Tugboat
repository with a git provider repository via a
[git provider integration](/setting-up-tugboat/connect-with-your-provider/). If you haven't already connected to a git
provider, you'll need to
[set up a git integration](/setting-up-tugboat/connect-with-your-provider/#adding-a-link-to-a-git-provider), and then
[delete the repository](/setting-up-tugboat/select-repo-settings/#delete-the-repository) from Tugboat and
[add it back to your project](/setting-up-tugboat/add-repos-to-the-project/) using the git provider integration.
{{% /notice %}}
