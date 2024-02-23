---
title: "Environment Variables"
date: 2019-09-17T11:26:07-04:00
weight: 5
---

This page covers Tugboat's environment variables. If you're looking for information on how to use custom environment
variables with Tugboat, see:
[Create Custom Environment Variables](/setting-up-services/how-to-set-up-services/custom-environment-variables).

- [Image Specific Environment Variables](#image-specific-variables)
- [Tugboat Environment Variables](#tugboat-environment-variables)
- [Exposed Service Variables](#exposed-service-variables)
- [Base Preview Variables](#base-preview-variables)
- [Git Provider Variables](#git-provider-variables)
    - [Git](#git-raw-git-repo)
    - [Bitbucket](#bitbucket)
    - [GitHub](#github)
    - [GitLab](#gitlab)
    - [Stash/Bitbucket Server](#stash-bitbucket-server)

<!-- START: Replace from auto-generated content in https://[tugboat-preview].tugboatqa.com/vars.md -->

## Image Specific Variables

These variables are added to some of [Tugboat's images](/reference/tugboat-images).

| Variable Name  | Description                                                                                                                                                                                                                                                                                                                                                              | Example Value               |
|:---------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------|
| **`$DOCROOT`** | On images that provide a webserver (such as `tugboatqa/httpd`, `tugboatqa/nginx`, or `tugboatqa/php` images that have Apache installed), the `$DOCROOT` environment variable points to the full path that Tugboat expects your document root to live. It's recommended to symlink your assets directory into place: e.g. `ln -snf "${TUGBOAT_ROOT}/build" "${DOCROOT}"`. | `/usr/local/apache2/htdocs` |

## Tugboat Environment Variables

Tugboat injects the following environment variables into every Service. These variables are available for the entire
lifetime of a Service. This includes both build-time as well as run-time. So, they can be used in Build Scripts as well
as run-time configuration files, etc.

| Variable Name                                 | Description                                                                                                                       | Example Value                                                   |
|:----------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------|
| **`$TUGBOAT_DEFAULT_SERVICE`**                | The friendly name of the default Service of the current Preview.                                                                  | `apache`                                                        |
| **`$TUGBOAT_DEFAULT_SERVICE_ID`**             | The ID of the default Service of the current Preview.                                                                             | `65d80b183a26bc1dcec69e21`                                      |
| **`$TUGBOAT_DEFAULT_SERVICE_TOKEN`**          | The authentication token for the default Service of the current Preview.                                                          | `jkm6qcfq2nutbqjrqdlo66n7zmwbnubb`                              |
| **`$TUGBOAT_DEFAULT_SERVICE_URL`**            | The full URL for the default Service of the current Preview. This is also the default URL for the Preview itself.                 | `https://pr381-jkm6qcfq2nutbqjrqdlo66n7zmwbnubb.tugboatqa.com/` |
| **`$TUGBOAT_DEFAULT_SERVICE_URL_HOST`**       | The "host" part of the URL for the default Service of the current Preview.                                                        | `pr381-jkm6qcfq2nutbqjrqdlo66n7zmwbnubb.tugboatqa.com`          |
| **`$TUGBOAT_DEFAULT_SERVICE_URL_PROTOCOL`**   | The "protocol" part of the URL for the default Service of the current Preview.                                                    | `https`                                                         |
| **`$TUGBOAT_DEFAULT_SERVICE_URL_PATH`**       | The "path" part of the URL for the default Service of the current Preview.                                                        | `/`                                                             |
| **`$TUGBOAT_DEFAULT_SERVICE_CONFIG_ALIASES`** | A comma-separated list of aliases configured for the default Service of the current Preview.                                      | `foo,bar,baz.example.com`                                       |
| **`$TUGBOAT_DEFAULT_SERVICE_CONFIG_DOMAIN`**  | The configured domain for the default Service of the current Preview.                                                             | `tugboatqa.com`                                                 |
| **`$TUGBOAT_PREVIEW_ID`**                     | The ID of the current Preview.                                                                                                    | `65d80b17a79d4412414fa382`                                      |
| **`$TUGBOAT_PREVIEW`**                        | The ref name used to build the current Preview. This is an alias of $TUGBOAT_PREVIEW_REF.                                         | `pr381`                                                         |
| **`$TUGBOAT_PREVIEW_NAME`**                   | The friendly name of the current Preview.                                                                                         | `DRAFT: Add examples to environment variables.`                 |
| **`$TUGBOAT_PREVIEW_REF`**                    | The ref name used to build the current Preview.                                                                                   | `pr381`                                                         |
| **`$TUGBOAT_PREVIEW_TYPE`**                   | What type of preview this is.                                                                                                     | `pullrequest`                                                   |
| **`$TUGBOAT_PREVIEW_SHA`**                    | The git SHA that the preview was built from.                                                                                      | `bb061e2f3e58272e1f7330cae0acdc80d8b23eda`                      |
| **`$TUGBOAT_PROJECT_ID`**                     | The ID of the project that the current Preview belongs to.                                                                        | `5bedc23e72db400001b8d0e5`                                      |
| **`$TUGBOAT_PROJECT`**                        | The friendly name of the project that the current Preview belongs to.                                                             | `TugboatQA`                                                     |
| **`$TUGBOAT_REPO_ID`**                        | The ID of the repo that the current Preview belongs to.                                                                           | `6067617b65f817042a1c367e`                                      |
| **`$TUGBOAT_REPO`**                           | The friendly name of the repo that the current Preview belongs to.                                                                | `TugboatQA/docs`                                                |
| **`$TUGBOAT_ROOT`**                           | The filesystem location where the git repository is cloned.                                                                       | `/var/lib/tugboat`                                              |
| **`$TUGBOAT_SERVICE_ID`**                     | The ID of the current service.                                                                                                    | `65d80b183a26bc1dcec69e21`                                      |
| **`$TUGBOAT_SERVICE`**                        | The friendly name of the current Service. This is also the hostname used to reference this Service container from other Services. | `apache`                                                        |
| **`$TUGBOAT_SMTP`**                           | The hostname of a Tugboat SMTP server that can be used to capture outbound email from the Preview.                                | `tugboat-agent-proxy.tugboatqa.tugboat.qa`                      |

## Exposed Service Variables

If a Service has an exposed HTTP port configured, the following variables are also available with information about the
Service's public URL.

| Variable Name                         | Description                                                                                                                                                                                                                                          | Example Value                                                   |
|:--------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------|
| **`$TUGBOAT_SERVICE_TOKEN`**          | The authentication token for the Tugboat Service. This is used by the Tugboat HTTP proxy to grant access to a Service and is passed through mostly as an informational value. Additional verification could be done in the application if necessary. | `jkm6qcfq2nutbqjrqdlo66n7zmwbnubb`                              |
| **`$TUGBOAT_SERVICE_URL`**            | The full URL of the current Service.                                                                                                                                                                                                                 | `https://pr381-jkm6qcfq2nutbqjrqdlo66n7zmwbnubb.tugboatqa.com/` |
| **`$TUGBOAT_SERVICE_URL_PROTOCOL`**   | The "protocol" part of the current service's URL.                                                                                                                                                                                                    | `https`                                                         |
| **`$TUGBOAT_SERVICE_URL_HOST`**       | The "host" part of the current service's URL.                                                                                                                                                                                                        | `pr381-jkm6qcfq2nutbqjrqdlo66n7zmwbnubb.tugboatqa.com`          |
| **`$TUGBOAT_SERVICE_URL_PATH`**       | The "path" part of the current service's URL.                                                                                                                                                                                                        | `/`                                                             |
| **`$TUGBOAT_SERVICE_CONFIG_ALIASES`** | A comma-separated list of aliases configured for the current service.                                                                                                                                                                                | `foo,bar,baz.example.com`                                       |
| **`$TUGBOAT_SERVICE_CONFIG_DOMAIN`**  | The configured domain for the current service.                                                                                                                                                                                                       | `tugboatqa.com`                                                 |

## Base Preview Variables

If a Preview was built from a Base Preview, the following variables are also available with information about the Base
Preview.

| Variable Name                            | Description                                                                                                                      | Example Value                                                       |
|:-----------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------|
| **`$TUGBOAT_BASE_PREVIEW`**              | The ref name used to build the Base Preview. This is an alias of `$TUGBOAT_BASE_PREVIEW_REF`.                                    | `main-node`                                                         |
| **`$TUGBOAT_BASE_PREVIEW_ID`**           | The ID of the Base Preview.                                                                                                      | `65d809f03a26bc1dcec697d9`                                          |
| **`$TUGBOAT_BASE_PREVIEW_NAME`**         | The friendly name of the Base Preview.                                                                                           | `main-node`                                                         |
| **`$TUGBOAT_BASE_PREVIEW_REF`**          | The ref name used to build the Base Preview.                                                                                     | `main-node`                                                         |
| **`$TUGBOAT_BASE_PREVIEW_TYPE`**         | What type of preview the Base Preview is. The value will be one of: `branch`, `tag`, `commit`, `pullrequest`, or `mergerequest`. | `branch`                                                            |
| **`$TUGBOAT_BASE_PREVIEW_TOKEN`**        | The authentication token of the Base Preview's default Service.                                                                  | `k6qz9y79gupbfr4lqko7xaofbazl28em`                                  |
| **`$TUGBOAT_BASE_PREVIEW_URL`**          | The public URL for the Base Preview's default Service.                                                                           | `https://main-node-k6qz9y79gupbfr4lqko7xaofbazl28em.tugboatqa.com/` |
| **`$TUGBOAT_BASE_PREVIEW_URL_PROTOCOL`** | The "protocol" part of the Base Preview's default Service URL.                                                                   | `https`                                                             |
| **`$TUGBOAT_BASE_PREVIEW_URL_HOST`**     | The "host" part of the Base Preview's default Service URL.                                                                       | `main-node-k6qz9y79gupbfr4lqko7xaofbazl28em.tugboatqa.com`          |
| **`$TUGBOAT_BASE_PREVIEW_URL_PATH`**     | The "path" part of the Base Preview's default Service URL.                                                                       | `/`                                                                 |

## Git Provider Variables

These variables are injected into Tugboat Previews that are built from a specific provider repository.

### Git (Raw git repo)

| Variable Name           | Description                        | Example Value                       |
|:------------------------|:-----------------------------------|:------------------------------------|
| **`$TUGBOAT_GIT_REPO`** | The address of the git repository. | git@myserver.com:TugboatQA/docs.git |

### Bitbucket

| Variable Name                        | Description                                                                                                                     | Example Value                                   |
|:-------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------|
| **`$TUGBOAT_BITBUCKET_OWNER`**       | The owner of the Bitbucket repository.                                                                                          | `TugboatQA`                                     |
| **`$TUGBOAT_BITBUCKET_SLUG`**        | The URL-friendly name of the Bitbucket repository. See https://confluence.atlassian.com/bitbucket/what-is-a-slug-224395839.html | `docs`                                          |
| **`$TUGBOAT_BITBUCKET_PR`**          | **PRs Only** - The Bitbucket pull request number.                                                                               | `381`                                           |
| **`$TUGBOAT_BITBUCKET_TITLE`**       | **PRs Only** - The title of the Bitbucket pull request.                                                                         | `DRAFT: Add examples to environment variables.` |
| **`$TUGBOAT_BITBUCKET_SOURCE`**      | **PRs Only** - The name of the pull request source branch.                                                                      | `chris/env-var-examples`                        |
| **`$TUGBOAT_BITBUCKET_DESTINATION`** | **PRs Only** - The name of the pull request destination branch.                                                                 | `main`                                          |

### GitHub

| Variable Name               | Description                                              | Example Value                                   |
|:----------------------------|:---------------------------------------------------------|:------------------------------------------------|
| **`$TUGBOAT_GITHUB_OWNER`** | The owner of the GitHub repository.                      | `TugboatQA`                                     |
| **`$TUGBOAT_GITHUB_REPO`**  | The name of the GitHub repository.                       | `docs`                                          |
| **`$TUGBOAT_GITHUB_PR`**    | **PRs Only** - The GitHub pull request number.           | `381`                                           |
| **`$TUGBOAT_GITHUB_TITLE`** | **PRs Only** - The title of the GitHub pull request.     | `DRAFT: Add examples to environment variables.` |
| **`$TUGBOAT_GITHUB_HEAD`**  | **PRs Only** - The name of the pull request head branch. | `chris/env-var-examples`                        |
| **`$TUGBOAT_GITHUB_BASE`**  | **PRs Only** - The name of the pull request base branch. | `main`                                          |

### GitLab

| Variable Name                   | Description                                                 | Example Value                                   |
|:--------------------------------|:------------------------------------------------------------|:------------------------------------------------|
| **`$TUGBOAT_GITLAB_NAMESPACE`** | The namespace of the GitLab repository.                     | `TugboatQA`                                     |
| **`$TUGBOAT_GITLAB_PROJECT`**   | The project name of the GitLab repository.                  | `docs`                                          |
| **`$TUGBOAT_GITLAB_MR`**        | **MRs Only** - The GitLab merge request number.             | `381`                                           |
| **`$TUGBOAT_GITLAB_TITLE`**     | **MRs Only** - The title of the GitLab merge request.       | `DRAFT: Add examples to environment variables.` |
| **`$TUGBOAT_GITLAB_SOURCE`**    | **MRs Only** - The name of the merge request source branch. | `chris/env-var-examples`                        |
| **`$TUGBOAT_GITLAB_TARGET`**    | **MRs Only** - The name of the merge request target branch. | `main`                                          |

### Stash / Bitbucket Server

| Variable Name                    | Description                                                                                                           | Example Value                                   |
|:---------------------------------|:----------------------------------------------------------------------------------------------------------------------|:------------------------------------------------|
| **`$TUGBOAT_STASH_PROJECT`**     | The project where the repository lives.                                                                               | `TugboatQA`                                     |
| **`$TUGBOAT_STASH_SLUG`**        | The URL-friendly name of the repository. See https://confluence.atlassian.com/bitbucket/what-is-a-slug-224395839.html | `docs`                                          |
| **`$TUGBOAT_STASH_PR`**          | **PRs Only** - The pull request number.                                                                               | `381`                                           |
| **`$TUGBOAT_STASH_TITLE`**       | **PRs Only** - The title of the pull request.                                                                         | `DRAFT: Add examples to environment variables.` |
| **`$TUGBOAT_STASH_SOURCE`**      | **PRs Only** - The name of the pull request source branch.                                                            | `chris/env-var-examples`                        |
| **`$TUGBOAT_STASH_DESTINATION`** | **PRs Only** - The name of the pull request destination branch.                                                       | `main`                                          |

<!-- END: Replace from auto-generated file. -->
