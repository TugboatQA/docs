---
title: "Tugboat Configuration"
date: 2019-09-17T11:26:18-04:00
lastmod: 2020-07-20T15:00:00-04:00
weight: 4
---

The following attributes control how a Service is built:

| Key                             | Type    | Description                                         |
| :------------------------------ | :------ | :-------------------------------------------------- |
| [image](#image)                 | String  | The Docker image to use for this Service            |
| [checkout](#checkout)           | Boolean | Whether to clone the git repository to this Service |
| [checkout_path](#checkout-path) | String  | Where to clone the git repository                   |
| [depends](#depends)             | List    | List of other Services that this Service depends on |
| [commands](#commands)           | List    | List of commands to run for various build stages    |

The following attributes configure how Service URLs are generated

| Key                       | Type    | Description                                               |
| :------------------------ | :------ | :-------------------------------------------------------- |
| [aliases](#aliases)       | List    | A list of aliases to generate URLs for                    |
| [alias_type](#alias-type) | String  | What kind of aliases to generate                          |
| [subpath](#subpath)       | Boolean | Whether subpath URLs should be generated for this Service |

The following attributes configure how the Tugboat proxy routes HTTP requests to the Service:

| Key                         | Type    | Description                                               |
| :-------------------------- | :------ | :-------------------------------------------------------- |
| [expose](#expose)           | Integer | Which port the Service should expose to the Tugboat proxy |
| [default](#default)         | Boolean | Whether this is the default Service for a Preview.        |
| [http](#http)               | Boolean | Whether the Service should be available via HTTP          |
| [https](#https)             | Boolean | Whether the Service should be available via HTTPS         |
| [domain](#domain)           | String  | A custom domain for Tugboat to generate URLs with         |
| [subpath_map](#subpath-map) | Boolean | Whether to map the generated subpath to "/"               |

The following attributes control which Service URLs are processed after a Preview is built, rebuilt, or refreshed.

| Key                       | Type | Description                                                              |
| :------------------------ | :--- | :----------------------------------------------------------------------- |
| [lighthouse](#lighthouse) | List | Lighthouse configurations to use for all URLs processed for the Service  |
| [screenshot](#screenshot) | List | Screenshot configurations to use for all URLs processed for the Service  |
| [visualdiff](#visualdiff) | List | Visual Diff configurations to use for all URLs processed for the Service |
| [urls](#urls)             | List | Which URLs should be processed for the Service                           |

The following attributes have been deprecated

| Key                         | Type | Description                                     |
| :-------------------------- | :--- | :---------------------------------------------- |
| [visualdiffs](#visualdiffs) | List | List of visualdiffs to generate for the Service |

---

#### `alias_type`

- **Type:** String
- **Default:** `default`
- **Required:** No

What type of URL aliases to generate for the Service. Valid options are `default` or `domain`. Alias URLs are generated
in addition to the normal Service URLs.

**`default`**

When `alias_type` is set to `default`, the alias URLs are constructed by substituting the preview name in the Service
URL with the values of `aliases`. The values of `aliases` are sanitized based on the value of [`subpath`](#subpath).

If `subpath` is `false`, alias values are sanitized to create a valid host name, and is truncated to 30 characters, to
make the host name a maximum of 63 characters. If `subpath` is `true`, the alias values are URL encoded.

If `aliases` is set to `['foo', 'bar']`, alias URLs look like the following

- https://foo-4vdrhxvyddvr5tne7zcr4y72vzowqohj.tugboat.qa
- https://bar-4vdrhxvyddvr5tne7zcr4y72vzowqohj.tugboat.qa

or

- https://previews.tugboat.qa/foo-4vdrhxvyddvr5tne7zcr4y72vzowqohj/
- https://previews.tugboat.qa/bar-4vdrhxvyddvr5tne7zcr4y72vzowqohj/

**`domain`**

When `alias_type` is set to `domain`, the alias URLs are constructing by substituting the domain part of the Service URL
with the values of `aliases`. The alias values are sanitized to create a valid domain name. If `aliases` is set to
`['foo.com', 'bar.com']`, alias URLs look like the following

- https://pr123-4vdrhxvyddvr5tne7zcr4y72vzowqohj.foo.com
- https://pr123-4vdrhxvyddvr5tne7zcr4y72vzowqohj.bar.com

or

- https://foo.com/pr123-4vdrhxvyddvr5tne7zcr4y72vzowqohj/
- https://bar.com/pr123-4vdrhxvyddvr5tne7zcr4y72vzowqohj/

In order for these domains to resolve, a DNS entry must be added to the alias domains as a `CNAME` to
`previews.tugboat.qa`. A wildcard entry is required if `subpath` is set to `false`.

---

#### `aliases`

- **Type:** List
- **Default:** _no default_
- **Required:** No

A list of aliases to generate URLs for. If set, additional alias URLs will be generated for the service. These URLs can
be used to route to different endpoints inside of the Service, such as for a Drupal Multisite. How the alias URLs are
constructed depend on the value of [`alias_type`](#alias-type)

---

#### `checkout`

- **Type:** Boolean
- **Default:** `false` (`true` when `default: true` is set)
- **Required:** No

Whether or not this Service should have a copy of the git repository cloned into it.

---

#### `checkout_path`

- **Type:** String
- **Default:** `/var/lib/tugboat`
- **Required:** No

Specifies the path where the git repository should be cloned if `checkout: true` is set. If this path already exists,
the clone will fail.

---

#### `commands`

- **Type:** List
- **Default:** _no default_
- **Required:** No

A set of commands to run during various points in a Preview's lifecycle. These commands are divided into the following
stages. Each stage consists of a list of commands. Each command is run in its own context, so things like changing
directories does not "stick" between commands. If that behavior is required, an external script should be called.

See also: [Service Commands](/setting-up-services/how-to-set-up-services/leverage-service-commands/) and
[Building a Preview -> The build process: explained](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained)

| Stage  | Description                                                                                            |
| :----- | :----------------------------------------------------------------------------------------------------- |
| init   | Commands that set up the basic Preview infrastructure, such as required packages or tools              |
| update | Commands that import data or other assets into a service, such as a database or image files            |
| build  | Commands that build or generate the site, such as compiling Sass or running database updates from code |
| ready  | Commands that indicate that a service is "ready", such as checking for a listening TCP port            |
| online | Commands to run once, after a Preview has built, is online, and is ready to accept incoming requests   |
| start  | Commands that should be run every time a Preview starts                                                |
| clone  | Commands that should be run on the cloned (new) Preview that has been created from an existing Preview |

The `init`, `update`, and `build` stages are related as follows:

- When a Preview is created, the commands in `init` are run, followed by the commands in `update`, and finally the
  commands in `build`.

- When a Preview is [refreshed](/building-a-preview/administer-previews/change-or-update-previews/#refresh-previews),
  the commands in `update` are run, followed by the commands in `build`.

- When a Preview is created from a Base Preview, only the commands in `build` are run.

The `online`, `start`, and `clone` commands all run after the build snapshot, so these commands are executed after the
build is complete (although `clone`ed commands are committed as a second build snapshot). For more info on the build
snapshot, see: [The Build Snapshot](/building-a-preview/preview-deep-dive/how-previews-work#the-build-snapshot).

---

#### `default`

- **Type:** Boolean
- **Default:** `false` (`true` if only one service is defined)
- **Required:** Yes, if more than one service is defined.

Whether this is the [default Service](/setting-up-services/how-to-set-up-services/define-a-default-service/) for a
Preview. The default Service is where incoming HTTP requests to the preview URL are routed. Setting this to true also
implies `expose: 80` and `checkout: true` unless those attributes are explicitly set otherwise.

---

#### `depends`

- **Type:** List
- **Default:** _no default_
- **Required:** No

Defines the order in which commands are executed between the defined Services. If one Service has a dependency on
another, it will wait for that Service's commands to run before running its own commands. If not set, there is no
guaranteed order in which Services will execute their commands relative to other Services.

---

#### `domain`

- **Type:** String
- **Default:** _no default_
- **Required:** No

A custom domain to use when generating URLs for the Service. If `example.com` is used, for example, URLs for the service
will resemble `http://pr123-token.example.com` or `http://preview.example.com/pr123-token/`, depending on the other
configuration values. Note that using a custom domain will result in browsers issuing SSL/TLS certificate warnings when
combined with `https: true`.

---

#### `expose`

- **Type:** Integer
- **Default:** _no default_ (`80` when `default: true` is set)
- **Required:** No

If this Service should be publicly accessible via HTTP/HTTPS, this is the port that the Tugboat Proxy will forward
incoming requests to.

---

#### `http`

- **Type:** Boolean
- **Default:** `false`
- **Required:** No

By default, Tugboat only generates HTTPS URLs and forces a redirect to HTTPS. Setting this value to `true` changes this
behavior to allow access to this Service's URL directly via HTTP on port 80.

---

#### `https`

- **Type:** Boolean
- **Default:** `true`
- **Required:** No

When `true`, this Service's URL is public accessible via HTTPS on port 443. In order to disable HTTPS for a Service URL,
`https` must be set to `false`, and `http` must be set to `true`. If both `https` and `http` are set to `true`, you’ll
get both `http` and `https` links.

---

#### `image`

- **Type:** String
- **Default:** _no default_
- **Required:** Yes

The Docker image to use for this Service. Tugboat maintains a set of images on
[Dockerhub](https://hub.docker.com/u/tugboatqa). These images all extend the official docker images, and are configured
to work well with Tugboat. See also:
[Specify a Service image](/setting-up-services/how-to-set-up-services/specify-a-service-image/).

---

#### `subpath`

- **Type:** Boolean
- **Default:** `false`
- **Required:** No

When `true`, the URL generated for this Service will be a subpath of the root Preview domain instead of a subdomain.
Using a subpath URL is not common, but can solve problems with testing advertisements or using OAuth

| subpath | URL Example                                                        |
| :------ | :----------------------------------------------------------------- |
| `true`  | https://preview.tugboat.qa/pr123-4vdrhxvyddvr5tne7zcr4y72vzowqohj/ |
| `false` | https://pr123-4vdrhxvyddvr5tne7zcr4y72vzowqohj.tugboat.qa          |

---

#### `subpath_map`

- **Type:** Boolean
- **Default:** `true`
- **Required:** No

When `true`, and `subpath: true` is set, URLs are rewritten by the Tugboat Proxy to replace the Preview-specific path
with `/` before being forwarded to the Service. When `false`, URLs are passed through as-is.

---

#### `lighthouse`

- **Type:** List
- **Default:** _no default_
- **Required:** No

Lighthouse configurations that affect all of the URLs defined for this Service. Values configured here override the
Tugboat default values, but can also be overridden per-URL.

| Option    | Type    | Default   | Description                                                                                                              |
| :-------- | :------ | :-------- | :----------------------------------------------------------------------------------------------------------------------- |
| `enabled` | Boolean | `true`    | Whether to render Lighthouse Reports for the URLs defined for this Service                                               |
| `config`  | Object  |           | A custom Lighthouse configuration object to use while rendering Lighthouse Reports for the URLs defined for this Service |
| `screen`  | List    | `desktop` | Which screens should be used when rendering Lighthouse Reports. Valid options are `desktop` and/or `mobile`              |

Tugboat uses the default Lighthouse configuration, but disables a few of the server performance metrics. These metrics
tend to be inaccurate due to the shared nature of the Tugboat infrastructure, and can negatively impact the overall
Lighthouse score.

Documentation for creating a custom Lighthouse configuration can be found at
https://github.com/GoogleChrome/lighthouse/blob/HEAD/docs/configuration.md

---

#### `screenshot`

- **Type:** List
- **Default:** _no default_
- **Required:** No

Screenshot configurations that affect all of the URLs defined for this Service. Values configured here override the
Tugboat default values, and can also be overridden per-URL.

| Option      | Type    | Default | Description                                                                                                                                                                      |
| :---------- | :------ | :------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `enabled`   | Boolean | `true`  | Whether to render Screenshots for the URLs defined for this Service                                                                                                              |
| `fullPage`  | Boolean | `true`  | Whether to use the default `fullPage` method. Disabling this uses an alternative that is more friendly to elements that have `vh` CSS Styles, but can sometimes be less accurate |
| `timeout`   | Number  | `30`    | How long to wait for a page to be ready when taking a screenshot, in seconds. Minimum: `1`, Maximum: `300`                                                                       |
| `waitUntil` | String  | `load`  | Which browser event to wait for before creating a screenshot of the page                                                                                                         |

The `waitUntil` option can be one of, or a list of, the following events. If a list of events is given, the screenshot
is created after all of the specified events have fired

| Event            | Description                                                                |
| :--------------- | :------------------------------------------------------------------------- |
| load             | Fires when the `load` event is fired                                       |
| domcontentloaded | Fires when the `DOMContentLoaded` event is fired                           |
| networkidle0     | Fires when there are no more than 0 network connections for at least 500ms |
| networkidle2     | Fires when there are no more than 2 network connections for at least 500ms |

---

#### `visualdiff`

- **Type:** List
- **Default:** _no default_
- **Required:** No

Visual Diff configurations that affect all of the URLs defined for this Service. Values configured here override the
Tugboat default values, and can also be overridden per-URL.

Visual Diffs can only be automatically generated for Previews built from a Base Preview. These options apply to
screenshots taken of the Base Preview used to compare to screenshots taken of this Preview.

| Option      | Type    | Default | Description                                                                                                                                                                          |
| :---------- | :------ | :------ | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `enabled`   | Boolean | `true`  | Whether to render Visual Diffs for the URLs defined for this Service. Visual Diffs depend on Screenshots being enabled. If Screenshots are disabled, this setting has no effect.     |
| `fullPage`  | Boolean | `true`  | Whether to use the default `fullPage` method. Disabling this uses an alternative that is more friendly to elements that have `vh` CSS Styles, but can sometimes be less accurate     |
| `timeout`   | Number  | `30`    | How long to wait for a page to be ready when taking a screenshot, in seconds. Minimum: `1`, Maximum: `300`                                                                           |
| `waitUntil` | String  | `load`  | Which browser event to wait for before creating a screenshot of the page                                                                                                             |
| `threshold` | Number  | `0`     | What percent similar a Visual Diff must be to the base preview in order to "pass". Visual Diffs that are less similar than this will generate an error. Minimum: `0`, Maximum: `100` |

The `waitUntil` option can be one of, or a list of, the following events. If a list of events is given, the screenshot
is created after all of the specified events have fired

| Event            | Description                                                                |
| :--------------- | :------------------------------------------------------------------------- |
| load             | Fires when the `load` event is fired                                       |
| domcontentloaded | Fires when the `DOMContentLoaded` event is fired                           |
| networkidle0     | Fires when there are no more than 0 network connections for at least 500ms |
| networkidle2     | Fires when there are no more than 2 network connections for at least 500ms |

---

#### `urls`

- **Type:** List
- **Default:** _no default_
- **Required:** No

Which URLs should be processed when a Preview has finished building. You can define URLs on any service that has an
exposed port. The URLs can be specified using one of the following formats:

##### Simple URL List

A simple list of strings can be provided. Each of the URLs will be processed according to the default Tugboat
configurations, or by Service-level `lighthouse`, `screenshot`, or `visualdiff` configurations

```yaml
urls:
  - /
  - /blog
  - /about
```

##### Advanced URL List

Each URL can be given configuration options that override the Tugboat defaults, or any Service-level configurations.

| Option     | Type   | Default    | Description                                                                                                                      |
| :--------- | :----- | :--------- | :------------------------------------------------------------------------------------------------------------------------------- |
| url        | String | _none_     | The relative URL to process. This option is required.                                                                            |
| aliases    | List   | `:default` | Use this list of [Service aliases](#aliases) when processing this URL. Each alias listed will be processed as an individual URL  |
| lighthouse | List   |            | Lighthouse configurations for this URL that override the Tugboat default, and specified Service-level lighthouse configurations  |
| screenshot | List   |            | Screenshot configurations for this URL that override the Tugboat default, and specified Service-level lighthouse configurations  |
| visualdiff | List   |            | Visual Diff configurations for this URL that override the Tugboat default, and specified Service-level lighthouse configurations |

The special `:default` alias tells Tugboat to use the default Service URL with no alias.

[lighthouse](#lighthouse), [screenshot](#screenshot), and [visualdiff](#visualdiff) configuration options are the same
as the Service-level options

Advanced URLs can be mixed with Simple URLs.

```yaml
urls:
  - /
  - /blog
  - url: /about
    aliases:
      - :default
      - foo
      - bar
    lighthouse:
      enabled: false
    screenshot:
      timeout: 45
    visualdiff:
      fullPage: false
```

##### Alias Groups

URLs can be grouped by alias, which is particularly useful if the aliases have different URL structures. Alias groups
can contain any combination of Simple or Advanced URL definitions as described above. The special `:default` alias means
to use the default Service URL with no alias.

```yaml
urls:
  :default:
    - /
    - /about
  foo:
    - url: /about
      lighthouse:
        enabled: false
  bar:
    - /
    - /blog
```

---

#### `visualdiffs`

{{% notice warning %}} This configuration is deprecated. Please use [urls](#urls) instead.  
{{% /notice %}}

- **Type:** List
- **Default:** _no default_
- **Required:** No

A set of visual diffs that should be generated for the Service. These visual diffs are generated automatically when a
Preview is created with a [base preview](/building-a-preview/work-with-base-previews/). They are then updated when the
Preview is [refreshed](/building-a-preview/administer-previews/change-or-update-previews/#refresh-previews) or
[rebuilt](/building-a-preview/administer-previews/change-or-update-previews/#rebuild-previews).

The visual diffs are specified by providing a list of _relative URLs_ to the Service. Each item in this list can be
either a string, such as `/blog`, or a map overriding the following screenshot options:

| Option    | Default    | Description                                                                                                                                              |
| :-------- | :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------- |
| url       | _none_     | The relative URL to create the visual diff for. This option is required                                                                                  |
| aliases   | `:default` | Only create visual diffs for these [Service aliases](#aliases). The special `:default` alias can be used to also generate a visual diff without an alias |
| timeout   | `30`       | How long to wait for a page to be ready when taking a screenshot, in seconds. Minimum: `1`, Maximum: `300`                                               |
| waitUntil | `load`     | Which event to wait for before creating a screenshot of a page.                                                                                          |
| fullPage  | `true`     | Disable this to use an alternate screenshot method that is more friendly to elements that have `vh` CSS styles                                           |

The `waitUntil` option can be one of, or a list of, the following events. If a list of events is given, the screenshot
is created after all of the specified events have fired

| Event            | Description                                                                |
| :--------------- | :------------------------------------------------------------------------- |
| load             | Fires when the `load` event is fired                                       |
| domcontentloaded | Fires when the `DOMContentLoaded` event is fired                           |
| networkidle0     | Fires when there are no more than 0 network connections for at least 500ms |
| networkidle2     | Fires when there are no more than 2 network connections for at least 500ms |

The visual diff URLs can optionally be grouped by [Service alias](#aliases), which is convenient when aliases have
different URL structures. Group URLs by nesting them in a map with the name of the alias they belong to. The special
`:default` alias can be used to create a group of URLs that should not use an alias.
