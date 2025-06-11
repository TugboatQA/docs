---
title: "Install Node.js"
date: 2023-09-11T17:04:07-04:00
weight: 1
---

If you need a specific version of Node.js on an image other than the `tugboatqa/node` image, we recommend using
[NodeSource distributions](https://github.com/nodesource/distributions) to do so. The majority of Tugboat images are
Debian-based.

For example, to install Node.js version 18.x on a PHP service:

```yaml
services:
  php:
    image: tugboatqa/php:8
    commands:
      init:
        - apt-get update
        - apt-get install -yq ca-certificates curl gnupg
        - mkdir -p /etc/apt/keyrings
        - curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o
          /etc/apt/keyrings/nodesource.gpg
        - echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" |
          tee /etc/apt/sources.list.d/nodesource.list
        - apt-get update
        - apt-get install -yq nodejs
```
