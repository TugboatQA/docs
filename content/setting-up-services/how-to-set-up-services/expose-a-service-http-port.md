+++
title = "Expose a Service HTTP Port"
date = 2019-09-19T13:04:27-04:00
weight = 5
+++

Every Service in a Preview gets a unique URL. That URL is accessible if:

- An HTTP service is running on the Service, AND;
- The port is exposed to the Tugboat Proxy.

To expose a port, include an `expose` key in the Service definition with the
port number that the HTTP service is listening on.

```yaml
services:
  node:
    image: tugboatqa/node:10
    expose: 3000
```

In this example, the Tugboat Proxy forwards requests to the service's URL
through to a nodejs service running on port 3000.

There are other options that affect how the proxy routing is handled. These
advanced options can usually be left to their default settings. Check out our
[Service Attributes reference](/setting-up-services/reference/service-attributes/)
for a complete list.

{{% notice note %}} When a Service is set as the `default`, port 80 is
automatically exposed. You can override this by using the `expose` key to
explicitly set an alternate port. {{% /notice %}}
