# Set the Document Root Path

Tugboat does not try to guess where your document root lives in your repository.
Likewise, it does not try to guess where a web server image expects to serve the
default document root from. This means you are responsible for making this link
in your [configuration](../../configuring-tugboat/index.md)

Each web server image expects the document root to be in a different location.
This is a side effect of using the
[Official Docker Images](https://docs.docker.com/docker-hub/official_repos/).
The [images](../../reference/services/index.md) provided by Tugboat store this
document root location in an environment variable named `$DOCROOT` for
convenience.

Use this [configuration](../../configuring-tugboat/index.md) to link the
document root to a directory named `/docroot` in your git repository. This works
for the following images provided by Tugboat: `tugboatqa/httpd`,
`tugboatqa/nginx`, `tugboatqa/php:apache`

```yaml
services:
  apache:
    image: tugboatqa/httpd
    commands:
      init:
        - ln -snf "${TUGBOAT_ROOT}/web" "${DOCROOT}"
```
