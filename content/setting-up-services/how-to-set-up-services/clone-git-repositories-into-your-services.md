+++
title = "Clone Git Repositories Into Your Services"
date = 2019-09-19T13:04:53-04:00
weight = 7
+++

When Tugboat runs, it clones your git repository into
[your `default` Service](../define-a-default-service/). Optionally, you can also
clone a copy of your git repository into other Services.

To explicitly request that a Service has access to the git repository, specify
the `checkout` key in the Service definition. This is especially useful if there
are Service-specific scripts or test data files committed to your git
repository.

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
    default: true
  mysql:
    image: tugboatqa/mysql:5.6
    checkout: true
```

In this example, both the `apache` and `mysql` services get a clone of the git
repository, checked out to the git branch, tag, commit, or pull request that the
preview is created for. The path where the git repository is cloned is available
in an [environment variable](/reference/environment-variables/) named
`$TUGBOAT_ROOT`.
