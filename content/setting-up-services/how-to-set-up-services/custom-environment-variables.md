---
title: "Create Custom Environment Variables"
date: 2019-09-26T15:39:08-04:00
weight: 9
---

Sometimes there are "secret" values or other data that you want to be made
available to a Preview, but you don't want to commit that data to git, and for
security reasons, you don't want to host it somewhere that Tugboat can grab it.
These secret values usually include things like API keys to 3rd party services,
or values used to encrypt session cookies that need to be unique to Tugboat but
shared between your Previews.

Tugboat provides a convenient way of injecting these values into a Preview's
services via custom environment variables. These variables can be found on the
[Repository Settings](/setting-up-tugboat/select-repo-settings/#change-repository-settings)
page.

![Environment Variable Configuration](/_images/envvars-config.png)

Like the other environment variables that Tugboat provides, the variables
entered here are available to your Previews both while they are building as well
as while they are running.

### Storing Complex Data

Environment variables are good at storing simple string values. However, what if
you need to store something more complex, like an encoded JSON string, or the
contents of an arbitrary file? One way of accomplishing that is to base64 encode
the value, and then decode the value with a
[configuration file command](/reference/tugboat-configuration/#commands).

```sh
$ cat file | base64
Q2h1Z2dhIENodWdnYSBUdWdib2F0IQo=
```

Store that value into an environment variable. Then, extract it to a file you
can use in your Preview with something like the following:

```sh
echo $VAR | base64 -D > /tmp/file
```
