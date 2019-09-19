---
title: "Warm a Page Cache Within Tugboat"
date: 2019-09-19T11:00:02-04:00
weight: 7
---

If your web application has a page caching layer, you can prime the cache from
within the
[Tugboat config file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file).
This code snippet should get you started:

```services:
  php:
    commands:
      build:
        # Warm the cache
        - "wget -e robots=off --quiet --page-requisites --delete-after --header \"Host: tugboat.qa\" http://localhost || /bin/true"
```

Calling `localhost` will cause Tugboat to load the front page of your
application. `page-requisites` loads all images, and `delete-after` removes the
downloaded assets to preserve disk space.
