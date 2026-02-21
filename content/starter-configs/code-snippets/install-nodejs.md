---
title: "Install Node.js"
date: 2023-09-11T17:04:07-04:00
weight: 1
---

If you need a specific version of Node.js on an image other than the `tugboatqa/node` image, we recommend using
[NodeSource distributions](https://nodesource.com/products/distributions) to do so. The majority of Tugboat images are
Debian-based.

For example, to install Node.js version 24.x on a PHP service:

```yaml
services:
  php:
    image: tugboatqa/php:8
    commands:
      init:
        - apt-get update
        - apt-get install -y curl
        - curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
        - apt-get install -y nodejs
```
