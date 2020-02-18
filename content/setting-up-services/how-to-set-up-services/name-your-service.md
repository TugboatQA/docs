+++
title = "Name Your Service"
date = 2019-09-19T13:03:33-04:00
weight = 1
+++

The top level of your [Config file](/setting-up-tugboat/create-a-tugboat-config-file/) is a `services` key whose value
is a list of Services.

```yaml
services:
  service1:
  service2:
  service3:
```

Service names are arbitrary, but they act as the internal host name for the Service. This is the name other Services in
the Preview would use to refer to the Service. As a result, there are a few rules you must observe when naming Services:

- Service names may only include the characters `a-z`, `0-9`, and `-`.
- Service names are limited to 39 characters.

As an example, a set of Services that serve a PHP-based site with a MySQL database and a Redis cache might be:

```yaml
services:
  apache:
  mysql:
  redis:
```
