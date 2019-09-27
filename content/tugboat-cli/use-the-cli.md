---
title: "Use the Cli"
date: 2019-09-19T10:41:55-04:00
weight: 3
---

## CLI commands

Run `tugboat help` to see a list of commands you can execute. A few options
include:

#### View info

- [List Tugboat Repositories](#list-tugboat-repositories)
- [List Tugboat Previews](#list-tugboat-previews)
- [View the Services in a Preview](#view-the-services-of-a-preview)
- [View Preview logs](#view-preview-logs)
- [View Service logs](#view-services-logs)

#### Administer Previews

- [Build a new Preview](#build-a-new-preview)
- [Delete a Preview](#delete-a-preview)

#### Shell into Services

- [Start a shell on the default Service of a Preview](#start-a-shell-on-the-default-service-of-a-preview)
- [Start a shell on a Service](#start-a-shell-on-a-service)

## View info

### List Tugboat repositories

```sh
tugboat ls repos
```

### List Tugboat Previews

```sh
tugboat ls previews
```

### View the Services of a Preview

To view the services of a preview with an ID of `5b04c7d14c3dad00016a2e80`:

```sh
tugboat ls services preview=5b04c7d14c3dad00016a2e80
```

### View Preview logs

To view the logs for a Preview with an ID of `5b04c7d14c3dad00016a2e80`:

```sh
tugboat log 5b04c7d14c3dad00016a2e80
```

### View Services logs

To view the logs for a Service with an ID of `5d092b16bd44cb22a498be90` that's
running in a Preview:

```sh
tugboat log 5d092b16bd44cb22a498be90
```

## Administer Previews

### Build a new Preview

To build a new Preview from the master branch of a Tugboat Repository with an ID
of `5b02ed093558930001c04cfa`:

```sh
tugboat create preview master repo=5b02ed093558930001c04cfa
```

### Delete a Preview

To force the deletion of a Preview with an ID of `5b04c7d14c3dad00016a2e80`:

```sh
tugboat delete 5b02ed093558930001c04cfa -f
```

## Start a shell into Services on a Preview

- [Start a shell on the default Service](#start-a-shell-on-the-default-service-of-a-preview)
- [Start a shell on a Service that isn't the default](#start-a-shell-on-a-service)

#### Start a shell on the default Service of a Preview

To start a shell on the
[default Service](/setting-up-services/how-to-set-up-services/define-a-default-service/)
of a Preview with an ID of `5b04c7d14c3dad00016a2e80`:

```sh
tugboat shell 5b04c7d14c3dad00016a2e80
```

#### Start a shell on a Service

To start a shell on Service that isn't the default:

1. Start by
   [viewing the Services of the Preview](#view-the-services-of-a-preview).
2. Find the Service where you want to start a shell.
3. Start the shell using the ID of the specific Service.

{{%expand "Visual Walkthrough" %}}

[View the Services of a Preview](#view-the-services-of-a-preview) via its ID; in
this case, `5d1a5305216a15d4bf5dcbbb`:

```sh
tugboat ls services preview=5d1a5305216a15d4bf5dcbbb
```

Find the Service ID for the Service where you want to start the shell; in this
case, I want the Service ID for the Service I've named `apache`:

![Find the Service ID](/_images/tugboat-cli-find-service-id.png)

Start the shell using the ID of the specific Service; in this example,
`5d1a5307216a158a155dcbc3`:

```sh
tugboat shell 5d1a5307216a158a155dcbc3
```

Now you've got shell access in that Service:

![Shell access in the Service](/_images/tugboat-cli-shell-access-in-service.png)

{{% /expand%}}
