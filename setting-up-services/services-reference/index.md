# Services reference

- [Service Attributes](#service-attributes)
- [Environment Variables](#environment-variables)
- [Custom Environment Variables](#custom-environment-variables)
- [Tugboat's Prebuilt Service images](#tugboats-prebuilt-service-images)

## Service Attributes

The following attributes control how a Service is built:

| Key                            | Type    | Description                                         |
| :----------------------------- | :------ | :-------------------------------------------------- |
| [image](#image)                | String  | The Docker image to use for this Service            |
| [checkout](#checkout)          | Boolean | Whether to clone the git repository to this Service |
| [checkout_path](#checkoutpath) | String  | Where to clone the git repository                   |
| [depends](#depends)            | List    | List of other Services that this Service depends on |
| [commands](#commands)          | List    | List of commands to run for various build stages    |
| [visualdiffs](#visualdiffs)    | List    | List of visualdiffs to generate for the Service     |

The following attributes configure how Service URLs are generated

| Key                      | Type    | Description                                               |
| :----------------------- | :------ | :-------------------------------------------------------- |
| [aliases](#aliases)      | List    | A list of aliases to generate URLs for                    |
| [alias_type](#aliastype) | String  | What kind of aliases to generate                          |
| [subpath](#subpath)      | Boolean | Whether subpath URLs should be generated for this Service |

The following attributes configure how the Tugboat proxy routes HTTP requests to
the Service:

| Key                        | Type    | Description                                               |
| :------------------------- | :------ | :-------------------------------------------------------- |
| [expose](#expose)          | Integer | Which port the Service should expose to the Tugboat proxy |
| [default](#default)        | Boolean | Whether this is the default Service for a Preview.        |
| [http](#http)              | Boolean | Whether the Service should be available via HTTP          |
| [https](#https)            | Boolean | Whether the Service should be available via HTTPS         |
| [domain](#domain)          | String  | A custom domain for Tugboat to generate URLs with         |
| [subpath_map](#subpathmap) | Boolean | Whether to map the generated subpath to "/"               |

---

#### `alias_type`

- **Type:** String
- **Default:** `default`
- **Required:** No

What type of URL aliases to generate for the Service. Valid options are
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

#### `aliases`

- **Type:** List
- **Default:** _no default_
- **Required:** No

A list of aliases to generate URLs for. If set, additional alias URLs will be
generated for the service. These URLs can be used to route to different
endpoints inside of the Service, such as for a Drupal Multisite. How the alias
URLs are constructed depend on the value of [`alias_type`](#aliastype)

---

#### `checkout`

- **Type:** Boolean
- **Default:** `false` (`true` when `default: true` is set)
- **Required:** No

Whether or not this Service should have a copy of the git repository cloned into
it.

---

#### `checkout_path`

- **Type:** String
- **Default:** `/var/lib/tugboat`
- **Required:** No

Specifies the path where the git repository should be cloned if `checkout: true`
is set. If this path already exists, the clone will fail.

---

#### `commands`

- **Type:** List
- **Default:** _no default_
- **Required:** No

A set of commands to run during various points in a Preview's lifecycle. These
commands are divided into the following stages. Each stage consists of a list of
commands. Each command is run in its own context, so things like changing
directories does not "stick" between commands. If that behavior is required, an
external script should be called.

See also:
[Service Commands](../how-to-set-up-services/index.md#leverage-service-commands-optional)
and
[Building a Preview -> The build process: explained](../../building-a-preview/how-previews-work/index.md#the-build-process-explained)

| Stage  | Description                                                                                            |
| :----- | :----------------------------------------------------------------------------------------------------- |
| init   | Commands that set up the basic Preview infrastructure, such as required packages or tools              |
| update | Commands that import data or other assets into a service, such as a database or image files            |
| build  | Commands that build or generate the site, such as compiling Sass or running database updates from code |
| ready  | Commands that indicate that a service is "ready", such as checking for a listening TCP port            |

The `init`, `update`, and `build` stages are related as follows:

- When a Preview is created, the commands in `init` are run, followed by the
  commands in `update`, and finally the commands in `build`.

- When a Preview is
  [refreshed](../../building-a-preview/administer-previews/index.md#refresh-previews),
  the commands in `update` are run, followed by the commands in `build`.

- When a Preview is created from a Base Preview, only the commands in `build`
  are run.

---

#### `default`

- **Type:** Boolean
- **Default:** `false` (`true` if only one service is defined)
- **Required:** Yes, if more than one service is defined.

Whether this is the
[default Service](../how-to-set-up-services/index.md#define-a-default-service)
for a Preview. The default Service is where incoming HTTP requests to the
preview URL are routed. Setting this to true also implies `expose: 80` and
`checkout: true` unless those attributes are explicitly set otherwise.

---

#### `depends`

- **Type:** List
- **Default:** _no default_
- **Required:** No

Defines the order in which commands are executed between the defined Services.
If one Service has a dependency on another, it will wait for that Service's
commands to run before running its own commands. If not set, there is no
guaranteed order in which Services will execute their commands relative to other
Services.

---

#### `domain`

- **Type:** String
- **Default:** _no default_
- **Required:** No

A custom domain to use when generating URLs for the Service. If `example.com` is
used, for example, URLs for the service will resemble
`http://pr123-token.example.com` or `http://preview.example.com/pr123-token/`,
depending on the other configuration values. Note that using a custom domain
will result in browsers issuing SSL/TLS certificate warnings when combined with
`https: true`.

---

#### `expose`

- **Type:** Integer
- **Default:** _no default_ (`80` when `default: true` is set)
- **Required:** No

If this Service should be publicly accessible via HTTP/HTTPS, this is the port
that the Tugboat Proxy will forward incoming requests to.

---

#### `http`

- **Type:** Boolean
- **Default:** `false`
- **Required:** No

By default, Tugboat only generates HTTPS URLs and forces a redirect to HTTPS.
Setting this value to `true` changes this behavior to allow access to this
Service's URL directly via HTTP on port 80.

---

#### `https`

- **Type:** Boolean
- **Default:** `true`
- **Required:** No

When `true`, this Service's URL is public accessible via HTTPS on port 443. In
order to disable HTTPS for a Service URL, `https` must be set to `false`, and
`http` must be set to `true`. If both `https` and `http` are set to `true`,
you’ll get both `http` and `https` links.

---

#### `image`

- **Type:** String
- **Default:** _no default_
- **Required:** Yes

The Docker image to use for this Service. Tugboat maintains a set of images on
[Dockerhub](https://hub.docker.com/u/tugboatqa). These images all extend the
official docker images, and are configured to work well with Tugboat. See also:
[Specify a Service image](../how-to-set-up-services/index.md#specify-a-service-image).

---

#### `subpath`

- **Type:** Boolean
- **Default:** `false`
- **Required:** No

When `true`, the URL generated for this Service will be a subpath of the root
Preview domain instead of a subdomain. Using a subpath URL is not common, but
can solve problems with testing advertisements or using OAuth

| subpath | URL Example                                                        |
| :------ | :----------------------------------------------------------------- |
| `true`  | https://preview.tugboat.qa/pr123-4vdrhxvyddvr5tne7zcr4y72vzowqohj/ |
| `false` | https://pr123-4vdrhxvyddvr5tne7zcr4y72vzowqohj.tugboat.qa          |

---

#### `subpath_map`

- **Type:** Boolean
- **Default:** `true`
- **Required:** No

When `true`, and `subpath: true` is set, URLs are rewritten by the Tugboat Proxy
to replace the Preview-specific path with `/` before being forwarded to the
Service. When `false`, URLs are passed through as-is.

---

#### `visualdiffs`

- **Type:** List
- **Default:** _no default_
- **Required:** No

A set of visual diffs that should be generated for the Service. These visual
diffs are generated automatically when a Preview is created with a
[base preview](../../building-a-preview/work-with-base-previews/index.md#how-to-set-a-base-preview).
They are then updated when the Preview is
[refreshed](../../building-a-preview/administer-previews/index.md#refresh-previews)
or
[rebuilt](../../building-a-preview/administer-previews/index.md#rebuild-previews).

The visual diffs are specified by providing a list of _relative URLs_ to the
Service. Each item in this list can be either a string, such as `/blog`, or a
map overriding the following screenshot options:

| Option    | Default    | Description                                                                                                                                              |
| :-------- | :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------------- |
| url       | _none_     | The relative URL to create the visual diff for. This option is required                                                                                  |
| aliases   | `:default` | Only create visual diffs for these [Service aliases](#aliases). The special `:default` alias can be used to also generate a visual diff without an alias |
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

The visual diff URLs can optionally be grouped by [Service alias](#aliases),
which is convenient when aliases have different URL structures. Group URLs by
nesting them in a map with the name of the alias they belong to. The special
`:default` alias can be used to create a group of URLs that should not use an
alias.

## Environment variables

Tugboat injects the following environment variables into every Service. These
variables are available for the entire lifetime of a Service. This includes both
build-time as well as run-time. So, they can be used in Build Scripts as well as
run-time configuration files, etc.

- **`TUGBOAT_DEFAULT_SERVICE`** - The friendly name of the default Service of
  the current Preview.

- **`TUGBOAT_DEFAULT_SERVICE_ID`** - The ID of the default Service of the
  current Preview.

- **`TUGBOAT_DEFAULT_SERVICE_TOKEN`** - The authentication token for the default
  Service of the current Preview.

- **`TUGBOAT_DEFAULT_SERVICE_URL`** - The full URL for the default Service of
  the current Preview. This is also the default URL for the Preview itself.

- **`TUGBOAT_DEFAULT_SERVICE_URL_HOST`** - The "host" part of the URL for the
  default Service of the current Preview.

- **`TUGBOAT_DEFAULT_SERVICE_URL_PROTOCOL`** - The "protocol" part of the URL
  for the default Service of the current Preview.

- **`TUGBOAT_DEFAULT_SERVICE_URL_PATH`** - The "path" part of the URL for the
  default Service of the current Preview.

- **`$TUGBOAT_DOMAIN`** - The root domain of the current Tugboat Preview

- **`$TUGBOAT_PREVIEW_ID`** - The ID of the current Preview.

- **`$TUGBOAT_PREVIEW`** - The friendly name of the current Preview.

- **`$TUGBOAT_PREVIEW_TYPE`** - What type of preview this is. The value will be
  one of: `branch`, `tag`, `commit`, `pullrequest`, or `mergerequest`.

- **`$TUGBOAT_PROJECT_ID`** - The ID of the project that the current Preview
  belongs to.

- **`$TUGBOAT_PROJECT`** - The friendly name of the project that the current
  Preview belongs to.

- **`$TUGBOAT_REPO_ID`** - The ID of the repo that the current Preview belongs
  to.

- **`$TUGBOAT_REPO`** - The friendly name of the repo that the current Preview
  belongs to.

- **`$TUGBOAT_ROOT`** - The filesystem location where the git repository is
  cloned.

- **`$TUGBOAT_SERVICE_ID`** - The ID of the current service.

- **`$TUGBOAT_SERVICE`** - The friendly name of the current Service. This is
  also the hostname used to reference this Service container from other
  Services.

- **`$TUGBOAT_SMTP`** - The hostname of a Tugboat SMTP server that can be used
  to capture outbound email from the Preview.

### Exposed Service Variables

If a Service has an exposed HTTP port configured, the following variables are
also available with information about the Service's public URL

- **`$TUGBOAT_SERVICE_TOKEN`** - The authentication token for the Tugboat
  Service. This is used by the Tugboat HTTP proxy to grant access to a Service
  and is passed through mostly as an informational value. Additional
  verification could be done in the application if necessary.

- **`$TUGBOAT_SERVICE_URL`** - The full URL of the current Service.

- **`$TUGBOAT_SERVICE_URL_PROTOCOL`** - The "protocol" part of the current
  service's URL.

- **`$TUGBOAT_SERVICE_URL_HOST`** - The "host" part of the current service's
  URL.

- **`$TUGBOAT_SERVICE_URL_PATH`** - The "path" part of the current service's
  URL.

### Base Preview Environment Variables

If a Preview was built from a Base Preview, the following variables are also
available with information about the Base Preview.

- **`$TUGBOAT_BASE_PREVIEW`** - The friendly name of the Base Preview.

- **`$TUGBOAT_BASE_PREVIEW_ID`** - The ID of the Base Preview.

- **`$TUGBOAT_BASE_PREVIEW_TOKEN`** - The authentication token of the Base
  Preview's default Service.

- **`$TUGBOAT_BASE_PREVIEW_URL`** - The public URL for the Base Preview's
  default Service.

- **`$TUGBOAT_BASE_PREVIEW_URL_PROTOCOL`** - The "protocol" part of the Base
  Preview's default Service URL.

- **`$TUGBOAT_BASE_PREVIEW_URL_HOST`** - The "host" part of the Base Preview's
  default Service URL.

- **`$TUGBOAT_BASE_PREVIEW_URL_PATH`** - The "path" part of the Base Preview's
  default Service URL.

### Provider-specific Environment Variables

#### Bitbucket

These variables are injected into Tugboat Previews that are built from a
Bitbucket repository.

- **`$TUGBOAT_BITBUCKET_OWNER`** - The owner of the Bitbucket repository.

- **`$TUGBOAT_BITBUCKET_SLUG`** - The URL-friendly name of the Bitbucket
  repository. See
  https://confluence.atlassian.com/bitbucket/what-is-a-slug-224395839.html

These variables are only injected into Tugboat Previews that are built from a
Bitbucket pull request.

- **`$TUGBOAT_BITBUCKET_PR`** - The Bitbucket pull request number.

- **`$TUGBOAT_BITBUCKET_TITLE`** - The title of the Bitbucket pull request.

* **`$TUGBOAT_BITBUCKET_SOURCE`** - The name of the pull request source branch.

* **`$TUGBOAT_BITBUCKET_DESTINATION`** - The name of the pull request
  destination branch.

#### Git

These variables are injected into Tugboat Previews that are built from a raw git
repository.

- **`$TUGBOAT_GIT_REPO`** - The address of the git repository.

#### GitHub

These variables are injected into Tugboat Previews that are built from a GitHub
repository.

- **`$TUGBOAT_GITHUB_OWNER`** - The owner of the GitHub repository.

- **`$TUGBOAT_GITHUB_REPO`** - The name of the GitHub repository.

These variables are only injected into Tugboat Previews that are built from a
GitHub pull request.

- **`$TUGBOAT_GITHUB_PR`** - The GitHub pull request number.

- **`$TUGBOAT_GITHUB_TITLE`** - The title of the GitHub pull request.

* **`$TUGBOAT_GITHUB_HEAD`** - The name of the pull request head branch.

* **`$TUGBOAT_GITHUB_BASE`** - The name of the pull request base branch.

#### GitLab

These variables are injected into Tugboat Previews that are built from a GitLab
repository.

- **`$TUGBOAT_GITLAB_NAMESPACE`** - The namespace of the GitLab repository.

- **`$TUGBOAT_GITLAB_PROJECT`** - The project name of the GitLab repository.

These variables are only injected into Tugboat Previews that are built from a
GitLab merge request.

- **`$TUGBOAT_GITLAB_MR`** - The GitLab merge request number.

- **`$TUGBOAT_GITLAB_TITLE`** - The title of the GitLab merge request.

* **`$TUGBOAT_GITLAB_SOURCE`** - The name of the merge request source branch.

* **`$TUGBOAT_GITLAB_TARGET`** - The name of the merge request target branch.

#### Stash / Bitbucket Server

These variables are injected into a Tugboat Previews that are built from a Stash
or Bitbucket Server repository.

- **`$TUGBOAT_STASH_PROJECT`** - The project where the repository lives.

- **`$TUGBOAT_STASH_SLUG`** - The URL-friendly name of the repository. See
  https://confluence.atlassian.com/bitbucket/what-is-a-slug-224395839.html

These variables are only injected into Tugboat Previews that are built from a
Stash or Bitbucket Server pull request.

- **`$TUGBOAT_STASH_PR`** - The pull request number.

- **`$TUGBOAT_STASH_TITLE`** - The title of the pull request.

* **`$TUGBOAT_STASH_SOURCE`** - The name of the pull request source branch.

* **`$TUGBOAT_STASH_DESTINATION`** - The name of the pull request destination
  branch.

### Custom Environment Variables

Sometimes there are "secret" values or other data that you want to be made
available to a Preview, but you don't want to commit that data to git, and for
security reasons, you don't want to host it somewhere that Tugboat can grab it.
These secret values usually include things like API keys to 3rd party services,
or values used to encrypt session cookies that need to be unique to Tugboat but
shared between your Previews.

Tugboat provides a convenient way of injecting these values into a Preview's
services via custom environment variables. These variables can be found on the
[Repository Settings](../../setting-up-tugboat/index.md#change-repository-settings)
page.

![Environment Variable Configuration](../../_images/envvars-config.png)

Like the other [environment variables](#environment-variables) that Tugboat
provides, the variables entered here are available to your Previews both while
they are building as well as while they are running.

#### Storing Complex Data

Environment variables are good at storing simple string values. However, what if
you need to store something more complex, like an encoded JSON string, or the
contents of an arbitrary file? One way of accomplishing that is to base64 encode
the value, and then decode the value with a
[configuration file command](#commands).

```sh
$ cat file | base64
Q2h1Z2dhIENodWdnYSBUdWdib2F0IQo=
```

Store that value into an environment variable. Then, extract it to a file you
can use in your Preview with something like the following:

```sh
echo $VAR | base64 -D > /tmp/file
```

## Tugboat's Prebuilt Service images

Tugboat maintains several Docker images. These images are extensions of
[official Docker images](https://docs.docker.com/docker-hub/official_repos) and
include tools and configurations that help them work well with Tugboat.
Tugboat's images track the upstream images.

All of our images are available on
[Docker Hub](https://hub.docker.com/u/tugboatqa/). The source code used to
generate these images is available on
[GitHub](https://github.com/TugboatQA/images).

It is best practice to use the most specific tag available for a given image to
prevent any unforeseen upstream changes from affecting your Previews. For
example, instead of `tugboatqa/mysql:5`, it is generally better to use
`tugboatqa/mysql:5.6`.

That said, sometimes the version of a Service doesn't really matter much. For
example, it may not matter which version of memcached you use, and you can be
sure you always have the most recent version available by specifying
`tugboatqa/memcached` or `tugboatqa/memcached:latest`. See also:
[Image version tags](../service-images/index.md#docker-image-version-tags-primer)

| Image                             | Usage                                  |                                                                                              |
| :-------------------------------- | :------------------------------------- | -------------------------------------------------------------------------------------------- |
| [Alpine](#alpine)                 | `image: tugboatqa/alpine:[TAG]`        | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/alpine/TAGS.md)        |
| Apache                            | `image: tugboatqa/httpd:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/httpd/TAGS.md)         |
| CentOS                            | `image: tugboatqa/centos:[TAG]`        | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/centos/TAGS.md)        |
| CouchDB                           | `image: tugboatqa/couchdb:[TAG]`       | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/couchdb/TAGS.md)       |
| Debian                            | `image: tugboatqa/debian:[TAG]`        | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/debian/TAGS.md)        |
| [Elastic Search](#elastic-search) | `image: tugboatqa/elasticsearch:[TAG]` | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/elasticsearch/TAGS.md) |
| [MariaDB](#mysqlmariadbpercona)   | `image: tugboatqa/mariadb:[TAG]`       | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/mariadb/TAGS.md)       |
| Memcached                         | `image: tugboatqa/memcached:[TAG]`     | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/memcached/TAGS.md)     |
| MongoDB                           | `image: tugboatqa/mongo:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/mongo/TAGS.md)         |
| [MySQL](#mysqlmariadbpercona)     | `image: tugboatqa/mysql:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/mysql/TAGS.md)         |
| Nginx                             | `image: tugboatqa/nginx:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/nginx/TAGS.md)         |
| Node                              | `image: tugboatqa/node:[TAG]`          | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/node/TAGS.md)          |
| [Percona](#mysqlmariadbpercona)   | `image: tugboatqa/percona:[TAG]`       | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/percona/TAGS.md)       |
| [PHP](#php)                       | `image: tugboatqa/php:[TAG]`           | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/php/TAGS.md)           |
| Redis                             | `image: tugboatqa/redis:[TAG]`         | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/redis/TAGS.md)         |
| Solr                              | `image: tugboatqa/solr:[TAG]`          | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/solr/TAGS.md)          |
| Ubuntu                            | `image: tugboatqa/ubuntu:[TAG]`        | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/ubuntu/TAGS.md)        |
| Varnish                           | `image: tugboatqa/varnish:[TAG]`       | [Supported Tags](https://github.com/TugboatQA/dockerfiles/blob/master/varnish/TAGS.md)       |

---

### Additional Information

#### Alpine

The Alpine image is extremely minimal by nature. Unlike the other images, it
does not have any extra tools installed except those required to use git with
SSH.

#### Elastic Search

The 2.x tags of this image extend the official Elast Search image on
[Docker Hub](https://hub.docker.com/_/elasticsearch/). These images are based on
Debian.

The newer tags of this image extend the official Elastic Search images
maintained by [Elastic.co](https://www.docker.elastic.co/). These images are
based on CentOS.

#### MySQL/MariaDB/Percona

The MySQL, MariaDB, and Percona images are configured the same way. Each have a
default database named `tugboat` as well as a user named `tugboat` with a
password of `tugboat`. The `tugboat` user has full access to the `tugboat`
database. In addition, the `root` database user does not have a password, but
can only be used to connect to the database from the MariaDB or MySQL service.

This means that in order to do any root-level database operations, they must be
done by the commands defined for the MySQL or MariaDB service.

```yaml
services:
  mysql:
    image: tugboatqa/mysql
    commands:
      init:
        - mysql -e "CREATE DATABASE foo;"
```

#### PHP

##### PHP Extensions

The PHP images provided [upstream](https://hub.docker.com/_/php/) do not use
apt-get to install PHP extensions. Instead, there are helper scripts that let
you install additional extensions as required. The images provided by Tugboat
attempt to balance installing the most commonly used extensions with reserving
as much disk space as possible. If an extension that you need is not installed,
use `docker-php-ext-configure`, `docker-php-ext-install`, and
`docker-php-ext-enable` in your Service commands.

```yaml
commands:
  init:
    # Install and enable the redis extension
    - pecl install redis
    - docker-php-ext-enable redis
```

More information about these helper scripts can be found in the
[upstream documentation](https://github.com/docker-library/docs/blob/master/php/README.md#how-to-install-more-php-extensions).

##### Apache Modules

In order to keep the service containers as lean as possible, only the most basic
apache modules are enabled in the PHP/Apache images. To enable a missing module,
add it with a service command

```yaml
commands:
  init:
    # Enable mod_rewrite and mod_headers
    - a2enmod rewrite headers
```
