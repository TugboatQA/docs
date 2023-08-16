---
title: "Install Node.js"
date: 2021-10-07T14:13:47-04:00
weight: 1
---

If you need a specific version of Node.js on an image other than the `tugboatqa/nodejs` image, we recommend using
[NodeSource distributions](https://github.com/nodesource/distributions) to do so. The majority of Tugboat images are
Debian-based.

For example, to install Node.js version 16.x on a PHP service:

```yaml
services:
  php:
    image: tugboatqa/php:8
    commands:
      init:
        - curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
        - apt-get install -y nodejs
```
