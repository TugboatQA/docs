+++
title = "Set the Document Root Path"
date = 2019-09-19T13:04:39-04:00
weight = 6
+++

Tugboat does not try to guess where your document root lives in your repository.
Likewise, it does not try to guess where a web server image expects to serve the
default document root from. This means you are responsible for making this link
in your [configuration file](/setting-up-tugboat/create-a-tugboat-config-file/)

Each web server image expects the document root to be in a different location.
This is a side effect of using the
[Official Docker Images](https://docs.docker.com/docker-hub/official_repos/).
The [images provided by Tugboat](../../service-images/using-tugboat-images/)
store this document root location in an environment variable named `$DOCROOT`
for convenience.

Use this configuration to link the document root to a directory named `/docroot`
in your git repository. This works for the following images provided by Tugboat:
`tugboatqa/httpd`, `tugboatqa/nginx`, `tugboatqa/php:apache`

```yaml
services:
  apache:
    image: tugboatqa/httpd
    commands:
      init:
        - ln -snf "${TUGBOAT_ROOT}/docroot" "${DOCROOT}"
```
