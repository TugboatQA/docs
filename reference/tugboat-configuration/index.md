# Tugboat Configuration File

Tugboat uses a file at `.tugboat/config.yml` in a git repository to configure
the previews it builds. Each preview is built from the `config.yml` file in its
own branch, tag, commit, or pull request. This file is required in order for
Tugboat to build any previews for a repository.

Below is an outline of the keys that Tugboat parses from `config.yml`.

* [`services`](#services)
  * [`<service_name>`](#servicename)
    * [`image`](#image)
    * [`default`](#default)
    * [`checkout`](#checkout)
    * [`checkout_path`](#checkoutpath)
    * [`depends`](#depends)
    * [`commands`](#commands)
      * [`init`](#init)
      * [`build`](#build)
      * [`update`](#update)
      * [`ready`](#ready)
    * [`expose`](#expose)
    * [`domain`](#domain)
    * [`http`](#http)
    * [`https`](#https)
    * [`https_redirect`](#httpsredirect)
    * [`subpath`](#subpath)
    * [`subpath_map`](#subpathmap)

## `services`

The only top-level key of the configuration file is `services`. It is a required
key, and is a map of the services required by a preview.

### `<service_name>`

Every service consists of the service's name as the key, and a map as the value.
The name must be unique in the `services` list, and must also be a valid host
name containing only the characters a-z, 0-9, and hyphen (`[a-z0-9-]`).

The following attributes control how a service is built:

| Key                            | Type          | Description                                             |
| :----------------------------- | :------------ | :------------------------------------------------------ |
| [image](#image)                | String        | The Docker image to use for this service                |
| [checkout](#checkout)          | Boolean       | Whether to clone the git repository to this service     |
| [checkout_path](#checkoutpath) | String        | Where to clone the git repository if `checkout` is true |
| [depends](#depends)            | String / List | List of other services that this service depends on     |
| [commands](#commands)          | List          | List of commands to run for various build stages        |

The following attributes configure how the Tugboat proxy routes HTTP requests to
the service:

| Key                              | Type    | Description                                                                  |
| :------------------------------- | :------ | :--------------------------------------------------------------------------- |
| [expose](#expose)                | Integer | Which port the service should expose to the Tugboat proxy                    |
| [default](#default)              | Boolean | Whether this is the default service for a preview. Implies `expose: 80`      |
| [http](#http)                    | Boolean | Whether the service should be available via HTTP (default: `true`)           |
| [https](#https)                  | Boolean | Whether the service should be available via HTTPS (default: `true`)          |
| [https_redirect](#httpsredirect) | Boolean | Whether HTTP requests should be redirected to HTTPS (default: `true`)        |
| [domain](#domain)                | String  | An optional custom domain for Tugboat to generate URLs with                  |
| [subpath](#subpath)              | Boolean | Whether subpath URLs should be generated for this service (default: `false`) |
| [subpath_map](#subpathmap)       | Boolean | Whether to map the generated subpath to "/" (default: `false`)               |

#### `image`

#### `default`

#### `expose`

#### `checkout`

#### `checkout_path`

#### `depends`

#### `commands`

##### `init`

##### `build`

##### `update`

##### `ready`

#### `http`

#### `https`

#### `https_redirect`

#### `subpath`

#### `subpath_map`

#### `domain`
