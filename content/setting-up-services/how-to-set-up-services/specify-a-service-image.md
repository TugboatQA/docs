+++
title = "Specify a Service Image"
date = 2019-09-19T13:03:46-04:00
weight = 2
+++

Because Tugboat uses Docker under the hood, every Service in your config file
must use a
[valid Docker image address](https://docs.docker.com/engine/reference/commandline/pull/).

Here's what you need to know about working with Service images in Tugboat:

- [How to call a Service image from Docker Hub](#how-to-call-a-service-image-from-docker-hub)
- [How to use a Docker image from another registry](#how-to-use-a-docker-image-from-another-registry)

If you want to pull a Docker image that isn't public, you'll need to
[authenticate with the Docker Registry](../../setting-up-tugboat/index.md#authenticate-with-a-docker-registry)
from your project's
[Repository Settings](../../setting-up-tugboat/index.md#change-repository-settings).

For a deeper dive on Service images in Tugboat, check out:

- [Using Tugboat's prebuilt Docker images](../service-images/index.md#tugboats-prebuilt-docker-images)
- [Using Third-party Docker images](../service-images/index.md#third-party-docker-images)
- [Using a Docker image to mirror your production services](../service-images/index.md#using-a-docker-image-to-mirror-your-production-services)
- [When does an image get pulled or updated?](../service-images/index.md#when-does-an-image-get-pulled-or-updated)

> #### Info::New to Docker images?
>
> Tugboat has abstracted away some of the technical aspects of working with
> Docker images, but if you're new to Docker, and want to understand more about
> Docker images,
> [check out Docker's documentation](https://docs.docker.com/v17.09/engine/userguide/storagedriver/imagesandcontainers/).

### How to call a Service image from Docker Hub

Tugboat's default image registry is [Docker Hub](https://hub.docker.com/). When
you use an `image` key in the Service definition, Tugboat pulls the
corresponding image from Docker Hub.

To call a Service image from Docker Hub, specify an `image` key in the Service
definition.

For example:

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
  msyql:
    image: tugboatqa/mysql:5.6
```

To dissect the key value in our Apache image key example above, we're calling:

`tugboatqa` : Profile of the image provider on Docker Hub; in this case, it's
[TugboatQA](https://hub.docker.com/u/tugboatqa), the organization.  
`httpd` : This is the specific image we're calling; in this case, it's Tugboat's
version of the [Apache HTTP Server](https://hub.docker.com/r/tugboatqa/httpd).  
`2.4` : **OPTIONAL** version tag; in this case, we're calling for the specific
2.4 version of Tugboat's Apache HTTP server image. If you browse to the
[supported images in our GitHub repo](https://github.com/TugboatQA/dockerfiles/blob/master/httpd/TAGS.md),
you can see a list of all the version tags available for Tugboat's Apache HTTP
Server image.

For more on version tags, take a look at our
[Docker image version tags primer](../service-images/index.md#docker-image-version-tags-primer).

### How to use a Docker image from another registry

If you want to use a Docker image from another registry, you'll need to specify
the alternate registry, since Tugboat pulls from Docker Hub by default.

For a full breakdown of how to pull from a different registry, check out
Docker's Docs:
[Pull from a different registry](https://docs.docker.com/engine/reference/commandline/pull/#pull-from-a-different-registry).

An example of this in action at Tugboat might look like:

`image: registry.example.com:5000/path-to-image/httpd:2.4`
