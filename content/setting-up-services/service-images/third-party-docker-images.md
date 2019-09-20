---
title: "Third Party Docker Images"
date: 2019-09-19T13:22:21-04:00
weight: 4
---

Theoretically, you can use any publicly available Docker image in your Tugboat
build. However, you may run into a limitation that can make third-party Docker
images problematic: Tugboat will not create a Service from an image that defines
any VOLUMES. For that reason, we recommend sticking with the images built
specifically for use with Tugboat.

If you'd like to use your own Docker images, this repo contains the scripts we
use to make an image Tugboat compatible: <https://github.com/TugboatQA/images>

{{% notice info %}} Under the hood, Tugboat commits the entire state of the
container (including files, databases, etc) to optimize Preview builds when it
takes
[the Build Snapshot](../../building-a-preview/how-previews-work/index.md#the-build-snapshot).
With a Build snapshot in place, a Preview built from a Base Preview only runs
the `build` steps - without importing a database or other required assets. (For
more info, take a look at:
[the build process: explained.](../../building-a-preview/how-previews-work/index.md#the-build-process-explained))
Because of this, the concept of Docker volumes doesn’t really mesh with the way
Tugboat uses images. {{% /notice %}}
