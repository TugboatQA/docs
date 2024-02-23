## Tugboat Environment Variables

Tugboat injects the following environment variables into every Service. These variables are available for the entire lifetime of a Service. This includes both build-time as well as run-time. So, they can be used in Build Scripts as well as run-time configuration files, etc.

| Variable Name | Description | Example Value |
|:--------------|:------------|:--------------|
| **`TUGBOAT_DEFAULT_SERVICE`** | The friendly name of the default Service of the current Preview. |  |
| **`TUGBOAT_DEFAULT_SERVICE_ID`** | The ID of the default Service of the current Preview. |  |
| **`TUGBOAT_DEFAULT_SERVICE_TOKEN`** | The authentication token for the default Service of the current Preview. |  |
| **`TUGBOAT_DEFAULT_SERVICE_URL`** | The full URL for the default Service of the current Preview. This is also the default URL for the Preview itself. |  |
| **`TUGBOAT_DEFAULT_SERVICE_URL_HOST`** | The "host" part of the URL for the default Service of the current Preview. |  |
| **`TUGBOAT_DEFAULT_SERVICE_URL_PROTOCOL`** | The "protocol" part of the URL for the default Service of the current Preview. |  |
| **`TUGBOAT_DEFAULT_SERVICE_URL_PATH`** | The "path" part of the URL for the default Service of the current Preview. |  |
| **`TUGBOAT_DEFAULT_SERVICE_CONFIG_ALIASES`** | A comma-separated list of aliases configured for the default Service of the current Preview. |  |
| **`TUGBOAT_DEFAULT_SERVICE_CONFIG_DOMAIN`** | The configured domain for the default Service of the current Preview. |  |
| **`TUGBOAT_PREVIEW_ID`** | The ID of the current Preview. |  |
| **`TUGBOAT_PREVIEW`** | The ref name used to build the current Preview. This is an alias of $TUGBOAT_PREVIEW_REF. |  |
| **`TUGBOAT_PREVIEW_NAME`** | The friendly name of the current Preview. |  |
| **`TUGBOAT_PREVIEW_REF`** | The ref name used to build the current Preview. |  |
| **`TUGBOAT_PREVIEW_TYPE`** | What type of preview this is. |  |
| **`TUGBOAT_PREVIEW_SHA`** | The git SHA that the preview was built from. |  |
| **`TUGBOAT_PROJECT_ID`** | The ID of the project that the current Preview belongs to. |  |
| **`TUGBOAT_PROJECT`** | The friendly name of the project that the current Preview belongs to. |  |
| **`TUGBOAT_REPO_ID`** | The ID of the repo that the current Preview belongs to. |  |
| **`TUGBOAT_REPO`** | The friendly name of the repo that the current Preview belongs to. |  |
| **`TUGBOAT_ROOT`** | The filesystem location where the git repository is cloned. |  |
| **`TUGBOAT_SERVICE_ID`** | The ID of the current service. |  |
| **`TUGBOAT_SERVICE`** | The friendly name of the current Service. This is also the hostname used to reference this Service container from other Services. |  |
| **`TUGBOAT_SMTP`** | The hostname of a Tugboat SMTP server that can be used to capture outbound email from the Preview. |  |

## Exposed Service Variables

If a Service has an exposed HTTP port configured, the following variables are also available with information about the Service's public URL.

| Variable Name | Description | Example Value |
|:--------------|:------------|:--------------|
| **`TUGBOAT_SERVICE_TOKEN`** | The authentication token for the Tugboat Service. This is used by the Tugboat HTTP proxy to grant access to a Service and is passed through mostly as an informational value. Additional verification could be done in the application if necessary. |  |
| **`TUGBOAT_SERVICE_URL`** | The full URL of the current Service. |  |
| **`TUGBOAT_SERVICE_URL_PROTOCOL`** | The "protocol" part of the current service's URL. |  |
| **`TUGBOAT_SERVICE_URL_HOST`** | The "host" part of the current service's URL. |  |
| **`TUGBOAT_SERVICE_URL_PATH`** | The "path" part of the current service's URL. |  |
| **`TUGBOAT_SERVICE_CONFIG_ALIASES`** | A comma-separated list of aliases configured for the current service. |  |
| **`TUGBOAT_SERVICE_CONFIG_DOMAIN`** | The configured domain for the current service. |  |

## Base Preview Variables

| Variable Name | Description | Example Value |
|:--------------|:------------|:--------------|

## Git Provider Variables

| Variable Name | Description | Example Value |
|:--------------|:------------|:--------------|

## Stash/BitBucket Server

| Variable Name | Description | Example Value |
|:--------------|:------------|:--------------|
