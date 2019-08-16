# Tugboat Configuration File

Tugboat uses a file at `.tugboat/config.yml` in a git repository to configure
the previews it builds. Each preview is built from the `config.yml` file in its
own branch, tag, commit, or pull request. This file is required in order for
Tugboat to build any previews for a repository.

The only top-level key of the configuration file is `services`. It is a required
key, and is a map of the services required by a preview.

Every service consists of the service's name as the key, and a map as the value.
The name must be unique in the `services` list, and must be a
[valid host name](https://en.wikipedia.org/wiki/Hostname#Restrictions_on_valid_hostnames)
of 39 characters or less containing only the characters `a-z`, `0-9`, and `-`.

The following attributes control how a service is built:

| Key                            | Type    | Description                                         |
| :----------------------------- | :------ | :-------------------------------------------------- |
| [image](#image)                | String  | The Docker image to use for this service            |
| [checkout](#checkout)          | Boolean | Whether to clone the git repository to this service |
| [checkout_path](#checkoutpath) | String  | Where to clone the git repository                   |
| [depends](#depends)            | List    | List of other services that this service depends on |
| [commands](#commands)          | List    | List of commands to run for various build stages    |
| [visualdiffs](#visualdiffs)    | List    | List of visualdiffs to generate for the service     |

The following attributes configure how service URLs are generated

| Key                      | Type    | Description                                               |
| :----------------------- | :------ | :-------------------------------------------------------- |
| [aliases](#aliases)      | List    | A list of aliases to generate URLs for                    |
| [alias_type](#aliastype) | String  | What kind of aliases to generate                          |
| [subpath](#subpath)      | Boolean | Whether subpath URLs should be generated for this service |

The following attributes configure how the Tugboat proxy routes HTTP requests to
the service:

| Key                        | Type    | Description                                               |
| :------------------------- | :------ | :-------------------------------------------------------- |
| [expose](#expose)          | Integer | Which port the service should expose to the Tugboat proxy |
| [default](#default)        | Boolean | Whether this is the default service for a preview.        |
| [http](#http)              | Boolean | Whether the service should be available via HTTP          |
| [https](#https)            | Boolean | Whether the service should be available via HTTPS         |
| [domain](#domain)          | String  | A custom domain for Tugboat to generate URLs with         |
| [subpath_map](#subpathmap) | Boolean | Whether to map the generated subpath to "/"               |

---

## `alias_type`

- **Type:** String
- **Default:** `default`
- **Required:** No

What type of URL aliases to generate for the service. Valid options are
`default` or `domain`. Alias URLs are generated in addition to the normal
Service URLs.

**`default`**

When `alias_type` is set to `default`, the alias URLs are constructed by
substituting the preview name in the Service URL with the values of `aliases`.
The values of `aliases` are sanitized based on the value of
[`subpath`](#subpath).

If `subpath` is `false`, alias values are sanitized to create a valid host name,
and is truncated to 30 characters, to make the host name a maximum of 63
characters. If `subpath` is `true`, the alias values are URL encoded.

If `aliases` is set to `['foo', 'bar']`, alias URLs look like the following

- https://foo-4vdrhxvyddvr5tne7zcr4y72vzowqohj.tugboat.qa
- https://bar-4vdrhxvyddvr5tne7zcr4y72vzowqohj.tugboat.qa

or

- https://previews.tugboat.qa/foo-4vdrhxvyddvr5tne7zcr4y72vzowqohj/
- https://previews.tugboat.qa/bar-4vdrhxvyddvr5tne7zcr4y72vzowqohj/

**`domain`**

When `alias_type` is set to `domain`, the alias URLs are constructing by
substituting the domain part of the Service URL with the values of `aliases`.
The alias values are sanitized to create a valid domain name. If `aliases` is
set to `['foo.com', 'bar.com']`, alias URLs look like the following

- https://pr123-4vdrhxvyddvr5tne7zcr4y72vzowqohj.foo.com
- https://pr123-4vdrhxvyddvr5tne7zcr4y72vzowqohj.bar.com

or

- https://foo.com/pr123-4vdrhxvyddvr5tne7zcr4y72vzowqohj/
- https://bar.com/pr123-4vdrhxvyddvr5tne7zcr4y72vzowqohj/

In order for these domains to resolve, a DNS entry must be added to the alias
domains as a `CNAME` to `previews.tugboat.qa`. A wildcard entry is required if
`subpath` is set to `false`.

---

## `aliases`

- **Type:** List
- **Default:** _no default_
- **Required:** No

A list of aliases to generate URLs for. If set, additional alias URLs will be
generated for the service. These URLs can be used to route to different
endpoints inside of the service, such as for a Drupal Multisite. How the alias
URLs are constructed depend on the value of [`alias_type`](#aliastype)

---

## `checkout`

- **Type:** Boolean
- **Default:** `false` (`true` when `default: true` is set)
- **Required:** No

Whether or not this service should have a copy of the git repository cloned into
it.

---

## `checkout_path`

- **Type:** String
- **Default:** `/var/lib/tugboat`
- **Required:** No

Specifies the path where the git repository should be cloned if `checkout: true`
is set. If this path already exists, the clone will fail.

---

## `commands`

- **Type:** List
- **Default:** _no default_
- **Required:** No

A set of commands to run during various points in a preview's lifecycle. These
commands are divided into the following stages. Each stage consists of a list of
commands. Each command is run in its own context, so things like changing
directories does not "stick" between commands. If that behavior is requried, an
external script should be called.

| Stage  | Description                                                                                            |
| :----- | :----------------------------------------------------------------------------------------------------- |
| init   | Commands that set up the basic preview infrastructure, such as required packages or tools              |
| update | Commands that import data or other assets into a service, such as a database or image files            |
| build  | Commands that build or generate the site, such as compiling Sass or running database updates from code |
| ready  | Commands that indicate that a service is "ready", such as checking for a listening TCP port            |

The `init`, `update`, and `build` stages are related as follows

- When a preview is created, the commands in `init` are run, followed by the
  commands in `update`, and finally the commands in `build`.

- When a preview is created from a base preview, only the commands in `build`
  are run.

- When a preview is refreshed, the commands in `update` are run, followed by the
  commands in `build`. This applies to any preview, even those created from a
  base preview.

---

## `default`

- **Type:** Boolean
- **Default:** `false` (`true` if only one service is defined)
- **Required:** Yes, if more than one service is defined.

Whether this is the default service for a preview. The default service is where
incoming HTTP requests to the preview URL are routed. Setting this to true also
implies `expose: 80` and `checkout: true` unless those attributes are explicitly
set otherwise.

---

## `depends`

- **Type:** List
- **Default:** _no default_
- **Required:** No

Defines the order in which commands are executed between the defined services.
If one service has a dependency on another, it will wait for that service's
commands to run before running its own commands. If not set, there is no
guaranteed order in which services will execute their commands relative to other
services.

---

## `domain`

- **Type:** String
- **Default:** _no default_
- **Required:** No

A custom domain to use when generating URLs for the service. If `example.com` is
used, for example, URLs for the service will resemble
`http://pr123-token.example.com` or `http://preview.example.com/pr123-token/`,
depending on the other configuration values. Note that using a custom domain
will result in browsers issuing SSL/TLS certificate warnings when combined with
`https: true`.

---

## `expose`

- **Type:** Integer
- **Default:** _no default_ (`80` when `default: true` is set)
- **Required:** No

If this service should be publicly accessible via HTTP/HTTPS, this is the port
that the Tugboat Proxy will forward incoming requests to.

---

## `http`

- **Type:** Boolean
- **Default:** `false`
- **Required:** No

By default, Tugboat only generates HTTPS URLs and forces a redirect to HTTPS.
Setting this value to `true` changes this behavior to allow access to this
service's URL directly via HTTP on port 80.

---

## `https`

- **Type:** Boolean
- **Default:** `true`
- **Required:** No

When `true`, this service's URL is public accessible via HTTPS on port 443. In
order to disable HTTPS for a service URL, `https` must be set to `false`, and
`http` must be set to `true`. If both `https` and `http` are set to `true`.

---

## `image`

- **Type:** String
- **Default:** _no default_
- **Required:** Yes

The Docker image to use for this service. Tugboat maintains a set of images on
[Dockerhub](https://hub.docker.com/u/tugboatqa). These images all extend the
official docker images, and are configured to work well with Tugboat.

---

## `subpath`

- **Type:** Boolean
- **Default:** `false`
- **Required:** No

When `true`, the URL generated for this service will be a subpath of the root
preview domain instead of a subdomain. Using a subpath URL is not common, but
can solve problems with testing advertisements or using OAuth

| subpath | URL Example                                                        |
| :------ | :----------------------------------------------------------------- |
| `true`  | https://preview.tugboat.qa/pr123-4vdrhxvyddvr5tne7zcr4y72vzowqohj/ |
| `false` | https://pr123-4vdrhxvyddvr5tne7zcr4y72vzowqohj.tugboat.qa          |

---

## `subpath_map`

- **Type:** Boolean
- **Default:** `true`
- **Required:** No

When `true`, and `subpath: true` is set, URLs are rewritten by the Tugboat Proxy
to replace the preview-specific path with `/` before being forwarded to the
service. When `false`, URLs are passed through as-is.

---

## `visualdiffs`

- **Type:** List
- **Default:** _no default_
- **Required:** No

A set of visual diffs that should be generated for the service. These visual
diffs are generated automatically when a preview is created with a
[base preview](../../concepts/base-previews/index.md). They are then updated
when the preview is refreshed or rebuilt.

The visual diffs are specified by providing a list of _relative URLs_ to the
service. Each item in this list can be either a string, such as `/blog`, or a
map overriding the following screenshot options

| Option    | Default    | Description                                                                                                                                              |
| :-------- | :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------- |
| url       | _none_     | The relative URL to create the visual diff for. This option is required                                                                                  |
| aliases   | `:default` | Only create visual diffs for these [service aliases](#aliases). The special `:default` alias can be used to also generate a visual diff without an alias |
| timeout   | `30`       | How long to wait for a page to be ready when taking a screenshot, in seconds. Minimum: `1`, Maximum: `300`                                               |
| waitUntil | `load`     | Which event to wait for before creating a screenshot of a page.                                                                                          |
| fullPage  | `true`     | Disable this to use an alternate screenshot method that is more friendly to elements that have `vh` CSS styles                                           |

The `waitUntil` option can be one of the following events. If a list of events
is given, the screenshot is created after all of the listed events have fired

| Event            | Description                                                                |
| :--------------- | :------------------------------------------------------------------------- |
| load             | Fires when the `load` event is fired                                       |
| domcontentloaded | Fires when the `DOMContentLoaded` event is fired                           |
| networkidle0     | Fires when there are no more than 0 network connections for at least 500ms |
| networkidle2     | Fires when there are no more than 2 network connections for at least 500ms |

The visual diff URLs can optionally be grouped by [service alias](#aliases),
which is convenient when aliases have different URL structures. Group URLs by
nesting them in a map with the name of the alias they belong to. The special
`:default` alias can be used to create a group of URLs that should not use an
alias.
