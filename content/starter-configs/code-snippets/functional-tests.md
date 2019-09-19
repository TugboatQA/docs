---
title: "Run Functional Tests"
date: 2019-09-19T10:59:31-04:00
weight: 5
---

Here is an example of how you might use Tugboat to run functional tests; add a
snippet like this to your
[configuration file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file).

In this case, the tests are run with CasperJS.

```yaml
services:
  apache:
    image: tugboatqa/node:8
    commands:
      init:
        - apt-get update
        - apt-get install -y phantomjs
      build:
        - casperjs test app.js
```
