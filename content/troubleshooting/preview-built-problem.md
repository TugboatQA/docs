---
title: "Preview has built incorrectly"
date: 2019-09-19T12:38:53-04:00
weight: 2
---

- [A Preview says it is "ready", but shows a blank page](#a-preview-says-it-is-ready-but-shows-a-blank-page)
- [A Preview is pulling the wrong Docker image](#a-preview-is-pulling-the-wrong-docker-image)
- [Using Base Previews: unexpected Preview build results](#using-base-previews-unexpected-preview-build-results)
- [Something in my Preview isn't right](#something-in-my-preview-isn-t-right)
- [Troubleshooting Visual Diffs](#troubleshooting-visual-diffs)

## A Preview says it is "ready", but shows a blank page

When a Preview says it is "ready", that means that it successfully ran the
[commands](/setting-up-services/how-to-set-up-services/leverage-service-commands) in your
[configuration file](/setting-up-tugboat/create-a-tugboat-config-file/), and none of those commands returned an error.
It does not necessarily mean that those commands did what you expected them to do. For example, your configuration might
set up a database, but not provide the correct password to some application config file. In this case, the Preview would
build successfully, but the application might not load.

To troubleshoot where this might have gone wrong:

1. Double-check the commands in the [configuration file](/setting-up-tugboat/create-a-tugboat-config-file/).
2. Check [the Preview's logs](../debug-config-file/#how-to-check-the-preview-logs) for any clues, and.
3. Make use of [Tugboat's terminal access](/tugboat-cli/) to the Preview to do the same type of troubleshooting you
   would do if this happened on your local installation.

## A Preview is pulling the wrong Docker image

Have you updated the Docker image you want your Preview to use, but it still appears to be pulling the old image? There
are a couple of things that could be in play here:

1. [Verify what version of the image you're calling](#verify-what-version-of-the-image-you-re-calling)
2. [Not all Preview Actions call the Docker image again](#rebuild-the-preview-from-scratch)

### Verify what version of the image you're calling

Maybe you thought you had left a version tag off, so you'd be getting the latest Docker image, but you had actually
called a [specific version of the image](/setting-up-services/service-images/image-version-tags) in the config file. (Or
vice versa! Maybe your config file calls `latest` or doesn't specify a version, but you actually need a specific image
version.) First thing's first; double-check whether you're calling a specific version of the Docker image in your
[config file](/setting-up-tugboat/create-a-tugboat-config-file/), and update as necessary.

### Rebuild the Preview from scratch

The more common issue is performing a Preview Action that doesn't actually call the Docker image specified in your
config file.

If you're building a Preview from a PR, and you've got a Base Preview set in your Tugboat project, the Preview from your
PR only executes commands in the `build` portion of the config file. Your Docker image is pulled before `init`.

For more info, see:
[When does Tugboat pull a Docker image](/setting-up-services/service-images/docker-pull/#when-does-tugboat-pull-a-docker-image),
and
[When does Tugboat update a Docker image?](/setting-up-services/service-images/docker-pull/#when-does-tugboat-update-a-docker-image)

Basically, this means building a Preview from a PR when you're using a Base Preview will never pull a new Docker image.

The practical fix for this issue is to
[build the Preview from scratch, without using the Base Preview](/building-a-preview/work-with-base-previews/building-new-previews/).
If you want to change the Docker image in your Base Preview, so all new Previews will build from the new image, you'll
need to [Rebuild](/building-a-preview/work-with-base-previews/change-or-update/#change-a-base-preview) the Base Preview.

{{% notice tip %}} If you're using the [Repository Setting](/setting-up-tugboat/select-repo-settings/) to
[Refresh Base Previews Automatically](/setting-up-tugboat/select-repo-settings/#refresh-base-previews-automatically),
this does _not_ update the Docker images used in your Preview. This only kicks off a
[Refresh](/building-a-preview/work-with-base-previews/change-or-update/#automatically-refresh-a-base-preview), which
runs config file commands from both `update` and `build`. You need to manually
[Rebuild a Base Preview](/building-a-preview/work-with-base-previews/change-or-update/#change-a-base-preview) to pull a
new Docker image. {{% /notice %}}

## Using Base Previews - unexpected Preview build results

When you're using Base Previews, you may experience a few different types of unexpected build results:

- [A Preview that I didn't expect to see got built](#a-preview-that-i-didn-t-expect-to-see-got-built)
- [A Preview that I did expect to see didn't build](#a-preview-that-i-did-expect-to-see-didn-t-build)

### A Preview that I didn't expect to see got built

When you build Previews after building a Base Preview, those Previews generate new Preview builds from every Base
Preview type that matches against the new Preview build. If you're seeing a build that you didn't expect,
[view your Base Preview types](/building-a-preview/work-with-base-previews/view-base-preview-types/) and verify they're
set for the appropriate
[Base Preview Type](/building-a-preview/preview-deep-dive/how-previews-work/#base-preview-auto-select).

One example might be that you have two Previews set as Base Previews: a
[Repository Base Preview](/building-a-preview/preview-deep-dive/how-previews-work/#repository-base-preview) and a
[Branch Base Preview](/building-a-preview/preview-deep-dive/how-previews-work/#branch-base-preview). When building a
Preview that matches against the Branch, you'll actually get two Preview builds: one for the Repository Base Preview,
and one for the Branch Base Preview, since both match the new Preview build. You can change the Base Preview Type - for
example, [stop using a Repository Base Preview](/building-a-preview/work-with-base-previews/stop-using-base-preview/),
or
[change the Base Preview Type to Branch Base Preview](/building-a-preview/work-with-base-previews/change-or-update/#change-base-preview-type) -
if you don't want every new Preview to build from both Base Previews.

### A Preview that I did expect to see didn't build

If you expected to see a Preview build that you don't see, there are a few different things to check:

- [Are you automatically building Previews from Pull Requests?](#automatically-building-previews-from-pull-requests)
- [Have you set the Base Preview you want to use?](#setting-base-previews)
- [Is your Base Preview set to the appropriate Base Preview Type?](#matching-against-base-preview-types)

#### Automatically building Previews from Pull Requests

In the Preview Won't Build section, we cover
[Previews are not building automatically](../preview-built-problem/#previews-are-not-building-automatically); this same
thing applies when you're using Base Previews. Go into [Repository Settings](/setting-up-tugboat/select-repo-settings/)
and make sure the repository you're building Previews from is set up to {{% ui-text %}}Build Pull Requests
Automatically{{% /ui-text %}}.

![Build Pull Requests Automatically](/_images/pr-probe.png)

#### Setting Base Previews

The next thing to check is whether the Base Preview you expected to see as the basis for the missing Preview build is
set as a Base Preview.

1. Go to [View Base Previews](/building-a-preview/work-with-base-previews/view-base-preview-types/) and confirm that the
   Base Preview you expect to see is listed there.
2. If not, you'll need to
   [set the Preview that you want to use as your Base Preview](/building-a-preview/work-with-base-previews/set-a-base-preview/).
   Then, all new Preview builds that match the
   [Base Preview Type](/building-a-preview/preview-deep-dive/how-previews-work/#base-preview-auto-select) you specified
   will build from that Base Preview.

#### Matching against Base Preview Types

Finally, verify that the Base Previews you're using are set to the appropriate
[Base Preview Types](/building-a-preview/preview-deep-dive/how-previews-work/#base-preview-auto-select). If you're not
seeing a Preview built from a Base Preview that you expect to see, that Base Preview might not be set for the expected
Base Preview Type.

One example might be that you have a Base Preview set as a Branch Base Preview instead of a Repository Base Preview, and
the pull request you're building the Preview from doesn't merge into that branch. In this case, you'd need to change the
Base Preview Type to Repository, to ensure that _all_ Previews built in this repository build from the Base Preview, or
manually build the Preview from the specific Base Preview you want to use.

1. Go to [View Base Preview Types](/building-a-preview/work-with-base-previews/view-base-preview-types/) and confirm
   that the Base Preview is set for the appropriate Base Preview Type.
2. If necessary,
   [change the Base Preview Type](/building-a-preview/work-with-base-previews/change-or-update/#change-base-preview-type)
   to produce the expected build results.
3. Alternately, if you don't want to change a Base Preview Type, you can
   [manually create a Preview build from a specific Base Preview](/building-a-preview/work-with-base-previews/building-new-previews/#build-a-preview-from-a-specific-base-preview).

## Something in my Preview isn't right

It's possible for a Preview to build, but to be missing something you expect to see. This is similar to the
["Preview says it is "ready", but shows a blank page"](#a-preview-says-it-is-ready-but-shows-a-blank-page) issue above;
your Preview may not have failed during the build process, but it's possible something in the configuration file didn't
execute as you expected.

To troubleshoot where this might have gone wrong:

1. Double-check the commands in the [configuration file](/setting-up-tugboat/create-a-tugboat-config-file/).
2. Check [the Preview's logs](../debug-config-file/#how-to-check-the-preview-logs) for any clues.
3. Make use of [Tugboat's terminal access](/tugboat-cli/) to the Preview to do the same type of troubleshooting you
   would do if this happened on your local installation.

If you can't figure out why something isn't as you expect in your Preview, let us know! Visit us at
[Help and Support](/support/); we're happy to help.

## Troubleshooting Visual Diffs

- [Visual diffs aren't displaying, or aren't displaying as I expect](#visual-diffs-aren-t-displaying-or-aren-t-displaying-as-i-expect)
- [URL not found](#url-not-found)
- [There was a problem generating Visual Diffs for this Preview.](#there-was-a-problem-generating-visual-diffs-for-this-preview)

### Visual diffs aren't displaying, or aren't displaying as I expect

To configure which pages have visual diffs generated, you need to specify the relative URLs of the pages in a
`visualdiffs` key in the Service definition. That information should be in the
[config file](/setting-up-tugboat/create-a-tugboat-config-file/) of the branch or PR that you're building, _not_ the
Base Preview.

Some things you might try when troubleshooting a visual diff include:

- Confirm the _relative URL_ is correct;
- Consider overriding the default timeout option;
- Consider overriding the default WaitUntil option.

#### Overriding the default timeout option

```yaml
services:
  apache:
    visualdiffs:
      # Create a visualdiff of /blog, but override the default timeout option
      - url: /blog
        timeout: 10
```

#### Overriding the default waitUntil option

```yaml
services:
  apache:
    visualdiffs:
      # Create a visualdiff of /about, but override the default waitUntil option
      - url: /about
        waitUntil: domcontentloaded
```

If you've verified the relative URLs are correct, and that information is in the config file of the branch or PR you're
building, but you're still not seeing what you expect to see, reach out to us at [help and support](/support/) - we're
happy to take a look!

### URL not found

If the URL you use when [configuring your visual diffs](/visual-diffs/using-visual-diffs/#how-to-configure-visual-diffs)
doesn't match a _relative URL_ in your site, you may see visual diff panes generate, but with "Not Found" message inside
the images. If this happens, [edit your config file](/setting-up-tugboat/create-a-tugboat-config-file/) to specify the
_relative URLs_ of the pages you want to diff, and then
[Rebuild](/building-a-preview/administer-previews/change-or-update-previews/#rebuild-previews) the Preview.

![URL Not Found in Visual Diff](/_images/visual-diffs-url-not-found.png)

### There was a problem generating Visual Diffs for this preview.

If there's an issue with the way your visual diffs key is configured, you may get the "There was a problem generating
Visual Diffs for this preview" error. This could be because of the _relative URLs_ in your
[config file](/setting-up-tugboat/create-a-tugboat-config-file/), or it could be that you need to override
[the default timeout option](#overriding-the-default-timeout-option) or the
[default waitUntil option](#overriding-the-default-waituntil-option). If you've tried those things, and are still having
problems, reach out to us at [help and support](/support/) - we're happy to take a look!
