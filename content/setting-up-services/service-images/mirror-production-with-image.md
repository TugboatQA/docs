---
title: "Using a Docker Image to Mirror Your Production Services"
date: 2019-09-19T13:22:09-04:00
weight: 3
---

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
