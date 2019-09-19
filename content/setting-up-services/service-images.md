---
title: "Service Images"
date: 2019-09-17T11:26:39-04:00
weight: 2
---

- [Docker image version tags primer](#docker-image-version-tags-primer)
- [Using Tugboat's Prebuilt Docker images](#tugboats-prebuilt-docker-images)
- [Using a Docker image to mirror your production Services](#using-a-docker-image-to-mirror-your-production-services)
- [Third-party Docker images](#third-party-docker-images)
- [When does a Docker image get pulled or updated?](#when-does-an-image-get-pulled-or-updated)

## Docker image version tags primer

Use tags to indicate specific versions of an image, if needed. In
[our how to call a Service image from Docker Hub example](../how-to-set-up-services/index.md#how-to-call-a-service-image-from-docker-hub),
we called:

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
  msyql:
    image: tugboatqa/mysql:5.6
```

In this example, we called versions `2.4` and `5.6` for the `httpd` and `mysql`
images. These are Docker image version tags.

You can specify version tags in a few different ways:

- [Point-release version tags](#point-release-version-tags)
- [Major version tags](#major-version-tags)
- [Latest version tags](#latest-version-tags)

> #### Note:: You don't have to specify a version tag
>
> If you don't need a specific version of a Service image, you can leave the tag
> off the image call. When you don't specify a tag, you'll get the latest
> version of that image. However, because `latest` pulls the newest version of
> an image, it could introduce a breaking change, so we recommend specifying
> major/minor versions as needed.

If you're not sure which version tag to use, you can always browse to the
service image on [Docker Hub](https://hub.docker.com/) and check out what tags
are available.

![Browse image tags on Docker Hub](../../_images/browse-tags-on-docker-hub.png)

### Point-release version tags:

Using specific version tags helps prevent breaking changes that come along with
incremental updates. In our example above, we've called `tugboatqa/mysql:5.6`
instead of `tugboatqa/mysql:5`.

### Major version tags

If you want to make sure you're using a specific major version, but don't care
about point releases, specify something like `tugboatqa/node:10` to ensure you
always use the latest available minor release of node 10.x.

### Latest version tags

In some cases, you're less likely to be worried about a specific version; for
example, it may not matter which version of memcached you use.

When you don't need to call for a specific version of a Service, using the image
name without a tag (`tugboatqa/memcached`), or the `latest` tag
(`tugboatqa/memcached:latest`) will get you the most recent version of a Service
image.

## Tugboat's prebuilt Docker images

Tugboat maintains several
[prebuilt Docker images](../reference-tugboat-images/index.md). These images are
extensions of
[official Docker images](https://docs.docker.com/docker-hub/official_repos/)
that include tools and configurations that help them work well with Tugboat.
Tugboat's images track the upstream images, meaning the `tugboat/httpd:2.4`
image extends the latest official `httpd:2.4` image.

For a complete list of Tugboat's images and tags, find us on
[Docker Hub](https://hub.docker.com/u/tugboatqa/).

You can check out the scripts we used to create these images on
[GitHub](https://github.com/TugboatQA/images).

> #### Note::I don't see a Service image that I need...
>
> We add new [prebuilt service images](../reference-tugboat-images/index.md) as
> users need them. If there is something you need that we have not yet added,
> [let us know](https://tugboat.qa/support), and we will work with you to try to
> get it added to the list. Alternatively, you are free to choose a generic
> service image, such as `debian`, `ubuntu`, or `centos`, and install any
> packages you might need.

## Using a Docker image to mirror your production Services

Using a Docker image to mirror your production services in Tugboat works the
same as pulling an image for any other Service in Tugboat. Follow the
[steps to set up Services in Tugboat](../how-to-set-up-services/index.md), and
specify your production image.

As you'll probably be pulling from a private repository, you may need to first:

1. [Authenticate with a Docker Registry](../../setting-up-tugboat/index.md#authenticate-with-a-docker-registry)
   from Tugboat's
   [Repository Settings](../../setting-up-tugboat/index.md#change-repository-settings).
2. Take a look at
   [using third-party Docker images with Tugboat](#third-party-docker-images)
   for info about caveats, as well as links to scripts you could use to optimize
   your own image for Tugboat.
3. If you're pulling from a private Docker repository that isn't on Docker Hub,
   you'll need to follow the process in:
   [Bring your own Docker image from another registry](../how-to-set-up-services/index.md#how-to-use-a-docker-image-from-another-registry).

## Third-party Docker images

Theoretically, you can use any publicly available Docker image in your Tugboat
build. However, you may run into a limitation that can make third-party Docker
images problematic: Tugboat will not create a Service from an image that defines
any VOLUMES. For that reason, we recommend sticking with the images built
specifically for use with Tugboat.

If you'd like to use your own Docker images, this repo contains the scripts we
use to make an image Tugboat compatible: <https://github.com/TugboatQA/images>

> #### Info:: Why are Docker volumes not supported on Tugboat?
>
> Under the hood, Tugboat commits the entire state of the container (including
> files, databases, etc) to optimize Preview builds when it takes
> [the Build Snapshot](../../building-a-preview/how-previews-work/index.md#the-build-snapshot).
> With a Build snapshot in place, a Preview built from a Base Preview only runs
> the `build` steps - without importing a database or other required assets.
> (For more info, take a look at:
> [the build process: explained.](../../building-a-preview/how-previews-work/index.md#the-build-process-explained))
>
> Because of this, the concept of Docker volumes doesn’t really mesh with the
> way Tugboat uses images.

## When does an image get pulled or updated?

Familiar with Docker, and looking for more specific information about when
images get pulled or updated in Tugboat? Here's what you need to know about
`docker pull` under the hood:

- [When does Tugboat pull a Docker image?](#when-does-tugboat-pull-a-docker-image)
- [When does Tugboat update a Docker image?](#when-does-tugboat-update-a-docker-image)

### When does Tugboat pull a Docker image?

Tugboat doesn't pull the images in your config file every time you open a pull
request, or refresh a Preview; it only does a `docker pull` (under the hood)
when:

- You
  [build a Preview](../../building-a-preview/administer-previews/index.md#build-previews)
  from scratch (without using a Base Preview)
- You
  [Rebuild](../../building-a-preview/administer-previews/index.md#rebuild-previews)
  a Preview that was not built from a
  [Base Preview](../../building-a-preview/work-with-base-previews/index.md#change-a-base-preview)

Otherwise, Tugboat relies on the images you pulled when the Preview was first
created; Preview Actions like
[Refreshing a Preview](../../building-a-preview/administer-previews/index.md#refresh-previews),
[Cloning a Preview](../../building-a-preview/administer-previews/index.md#duplicate-a-preview),
or
[automatically generating a Preview from a pull request](../../building-a-preview/automate-previews/index.md#auto-generate-previews)
when you're using a Base Preview - those things all keep the Docker images you
referenced when you first built the Preview.

### When does Tugboat update a Docker image?

Because Tugboat pulls your Docker images at the beginning of the Preview build
process, it won't `docker pull` an updated image unless you kick off the Preview
build process from scratch again.

For more info, see:
[Why Build phases matter](../../building-a-preview/how-previews-work/index.md#why-build-phases-matter).

> #### Hint:: Tugboat Preview isn't pulling your latest image tag?
>
> If your Tugboat Preview isn't pulling your latest Docker image tag, it might
> be because you're building from a Base Preview. If that's the case, you'll
> need to
> [Rebuild your Base Preview](../../building-a-preview/work-with-base-previews/index.md#change-a-base-preview),
> which executes an API call to `docker pull` under the hood to grab the image
> tag referenced in your
> [config file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file).
>
> If that still doesn't get you the image you expect, check your
> [config file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file)
> to see which [image tag](#docker-image-version-tags-primer) you're pulling;
> you may need to change the reference to latest, or a specific image tag, to
> get the result you want.
