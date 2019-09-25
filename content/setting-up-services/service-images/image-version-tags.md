---
title: "Docker Image Version Tags Primer"
date: 2019-09-19T13:20:53-04:00
weight: 1
---

Use tags to indicate specific versions of an image, if needed. In
[our how to call a Service image from Docker Hub example](/setting-up-services/how-to-set-up-services/specify-a-service-image/#how-to-call-a-service-image-from-docker-hub),
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

{{% notice note %}} If you don't need a specific version of a Service image, you
can leave the tag off of the image call. When you don't specify a tag, you'll
get the latest version of that image. However, because `latest` pulls the newest
version of an image, it could introduce a breaking change, so we recommend
specifying major/minor versions as needed. {{% /notice %}}

If you're not sure which version tag to use, you can always browse to the
service image on [Docker Hub](https://hub.docker.com/) and check out what tags
are available.

![Browse image tags on Docker Hub](../../../_images/browse-tags-on-docker-hub.png)

## Point-release version tags:

Using specific version tags helps prevent breaking changes that come along with
incremental updates. In our example above, we've called `tugboatqa/mysql:5.6`
instead of `tugboatqa/mysql:5`.

## Major version tags

If you want to make sure you're using a specific major version, but don't care
about point releases, specify something like `tugboatqa/node:10` to ensure you
always use the latest available minor release of node 10.x.

## Latest version tags

In some cases, you're less likely to be worried about a specific version; for
example, it may not matter which version of memcached you use.

When you don't need to call for a specific version of a Service, using the image
name without a tag (`tugboatqa/memcached`), or the `latest` tag
(`tugboatqa/memcached:latest`) will get you the most recent version of a Service
image.
