---
title: "Docker Pull under the hood"
date: 2019-09-19T13:22:39-04:00
weight: 5
---

Familiar with Docker, and looking for more specific information about when images get pulled or updated in Tugboat?
Here's what you need to know about `docker pull` under the hood:

- [When does Tugboat pull a Docker image?](#when-does-tugboat-pull-a-docker-image)
- [When does Tugboat update a Docker image?](#when-does-tugboat-update-a-docker-image)

## When does Tugboat pull a Docker image?

Tugboat doesn't pull the images in your config file every time you open a pull request, or refresh a Preview; it only
does a `docker pull` (under the hood) when:

- You [build a Preview](/building-a-preview/administer-previews/build-previews/) from scratch (without using a Base
  Preview)
- You [Rebuild](/building-a-preview/administer-previews/change-or-update-previews/#rebuild-previews) a Preview that was
  not built from a Base Preview

Otherwise, Tugboat relies on the images you pulled when the Preview was first created; Preview Actions like
[Refreshing a Preview](/building-a-preview/administer-previews/change-or-update-previews/#refresh-previews),
[Cloning a Preview](/building-a-preview/administer-previews/build-previews/#duplicate-a-preview), or
[automatically generating a Preview from a pull request](/building-a-preview/automate-previews/auto-generate/) when
you're using a Base Preview - those things all keep the Docker images you referenced when you first built the Preview.

## When does Tugboat update a Docker image?

Because Tugboat pulls your Docker images at the beginning of the Preview build process, it won't `docker pull` an
updated image unless you kick off the Preview build process from scratch again.

For more info, see:
[Why Build phases matter](/building-a-preview/preview-deep-dive/how-previews-work/#why-build-phases-matter).

{{% notice tip %}} If your Tugboat Preview isn't pulling your latest Docker image tag, it might be because you're
building from a Base Preview. If that's the case, you'll need to
[Rebuild your Base Preview](/building-a-preview/work-with-base-previews/change-or-update/#change-a-base-preview), which
executes an API call to `docker pull` under the hood to grab the image tag referenced in your
[config file](/setting-up-tugboat/create-a-tugboat-config-file). If that still doesn't get you the image you expect,
check your config file to see which [image tag](../image-version-tags/) you're pulling; you may need to change the
reference to latest, or a specific image tag, to get the result you want. {{% /notice %}}
