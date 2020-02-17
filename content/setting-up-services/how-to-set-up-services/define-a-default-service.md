+++
title = "Define a Default Service"
date = 2019-09-19T13:04:10-04:00
weight = 4
+++

Every [Config file](/setting-up-tugboat/create-a-tugboat-config-file/) requires a default Service. The default Service
is where HTTP requests are routed when a [Preview's URL](/building-a-preview/share-a-preview/) is visited by a user.

If your Config file only has one Service, that Service automatically becomes the default Service.

If your Config file contains multiple Services, you must designate one of them as the `default`. Specify a default
Service by adding a `default` key to the Service, with a value of `true`.

```yaml
services:
  apache:
    image: tugboatqa/httpd:2.4
    default: true
  mysql:
    image: tugboatqa/mysql:5.6
```

{{% notice note %}} Setting a Service as the `default` - including when the Service is automatically designated
`default` because it's the only Service - also implies that port 80 is exposed to the Tugboat Proxy, and that the git
repository is cloned to /var/lib/tugboat. To override the Service HTTP port, see:
[Expose a Service HTTP port](../expose-a-service-http-port/). To override the git repository clone destination, see:
[Clone Git repositories into your Services](../clone-git-repositories-into-your-services/). {{% /notice %}}
