---
title: "Create Custom Environment Variables"
date: 2019-09-26T15:39:08-04:00
weight: 9
---

Sometimes there are "secret" values or other data that you want to be made available to a Preview, but you don't want to
commit that data to git, and for security reasons, you don't want to host it somewhere that Tugboat can grab it. These
secret values usually include things like API keys to 3rd party services, or values used to encrypt session cookies that
need to be unique to Tugboat but shared between your Previews.

Tugboat provides a convenient way of injecting these values into a Preview's services via custom environment variables.
These variables can be found on the
[Repository Settings](/setting-up-tugboat/select-repo-settings/#change-repository-settings) page.

![Environment Variable Configuration](/_images/envvars-config.png)

Like the other environment variables that Tugboat provides, the variables entered here are available to your Previews
both while they are building as well as while they are running.

When you're working with custom environment variables in Tugboat, you may want to:

- [Limit environment variables to only be available at certain points in the build process](#define-a-scope-for-environment-variable-availability)
- [Store complex data in a custom environment variable](#storing-complex-data)

## Define a scope for environment variable availability

For security reasons, you may want to limit the scope of environment variables containing sensitive data to only be
available when they are needed. By default, Tugboat's custom environment variables are always available, but you can
define specific times in the build process for these variables to be available.

You can specify scope for environment variable availability in a few ways:

- [Via the Repository Settings in the Tugboat Dashboard](#specify-environment-variable-availability-scope-via-the-tugboat-repository-settings-ui)
- [Via the CLI or API](#specify-environment-variable-availability-scope-via-cli-or-api)

### Specify environment variable availability scope via the Tugboat Repository Settings UI

When you go to add or edit a custom environment variable from the Repository Settings screen, you'll see checkboxes
where you can specify the envvar scope.

![Environment Variable Scope checkboxes in Repository Settings UI](/_images/environment-variable-scope-in-ui.png)

You can specify `Build-time Variable`, `Run-Time Variable`, both, or neither.

### Specify environment variable availability scope via CLI or API

If you use the [Tugboat CLI](/tugboat-cli), you can specify the environment variable availability using arguments on
`id=repository_id`. The Tugboat CLI takes `envvars`, `buildvars`, and `runvars` arguments for global, build time, and
runtime variables.

Global environment variable example:

```sh
tugboat update [repository_id] envvars=foo=bar,key=value
```

Build-time-scoped environment variable example:

```sh
tugboat update [repository_id] buildvars=foo=bar,key=value
```

Runtime-scoped environment variable example:

```sh
tugboat update [repository_id] runvars=foo=bar,key=value
```

If you're using [the API](https://api.tugboat.qa/), you can pass an environment variable array, including scope, via the
Create a Repository POST or the Update a Repository PATCH endpoints.

## Storing Complex Data

Environment variables are good at storing simple string values. However, what if you need to store something more
complex, like an encoded JSON string, or the contents of an arbitrary file? One way of accomplishing that is to base64
encode the value, and then decode the value with a
[configuration file command](/reference/tugboat-configuration/#commands).

```sh
$ cat file | base64
Q2h1Z2dhIENodWdnYSBUdWdib2F0IQo=
```

Store that value into an environment variable. Then, extract it to a file you can use in your Preview with something
like the following:

```sh
echo $VAR | base64 -D > /tmp/file
```
