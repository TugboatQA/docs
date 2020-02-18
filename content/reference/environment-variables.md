---
title: "Environment Variables"
date: 2019-09-17T11:26:07-04:00
weight: 5
---

- [Tugboat Environment Variables](#tugboat-environment-variables)
- [Exposed Service Variables](#exposed-service-variables)
- [Base Preview Environment Variables](#base-preview-environment-variables)
- [Provider-specific environment variables](#provider-specific-environment-variables)
  - [Bitbucket](#bitbucket)
  - [Git](#git)
  - [GitHub](#github)
  - [GitLab](#gitlab)
  - [Stash/Bitbucket Server](#stash-bitbucket-server)
- [Custom Environment Variables](#custom-environment-variables)
  - [Storing complex data](#storing-complex-data)

## Tugboat Environment Variables

Tugboat injects the following environment variables into every Service. These variables are available for the entire
lifetime of a Service. This includes both build-time as well as run-time. So, they can be used in Build Scripts as well
as run-time configuration files, etc.

- **`$TUGBOAT_DEFAULT_SERVICE`** - The friendly name of the default Service of the current Preview.

- **`$TUGBOAT_DEFAULT_SERVICE_ID`** - The ID of the default Service of the current Preview.

- **`$TUGBOAT_DEFAULT_SERVICE_TOKEN`** - The authentication token for the default Service of the current Preview.

- **`$TUGBOAT_DEFAULT_SERVICE_URL`** - The full URL for the default Service of the current Preview. This is also the
  default URL for the Preview itself.

- **`$TUGBOAT_DEFAULT_SERVICE_URL_HOST`** - The "host" part of the URL for the default Service of the current Preview.

- **`$TUGBOAT_DEFAULT_SERVICE_URL_PROTOCOL`** - The "protocol" part of the URL for the default Service of the current
  Preview.

- **`$TUGBOAT_DEFAULT_SERVICE_URL_PATH`** - The "path" part of the URL for the default Service of the current Preview.

- **`$TUGBOAT_DEFAULT_SERVICE_CONFIG_ALIASES`** - A comma-separated list of aliases configured for the default Service
  of the current Preview.

- **`$TUGBOAT_DEFAULT_SERVICE_CONFIG_DOMAIN`** - The configured domain for the default Service of the current Preview.

- **`$TUGBOAT_PREVIEW_ID`** - The ID of the current Preview.

- **`$TUGBOAT_PREVIEW`** - The friendly name of the current Preview.

- **`$TUGBOAT_PREVIEW_TYPE`** - What type of preview this is. The value will be one of: `branch`, `tag`, `commit`,
  `pullrequest`, or `mergerequest`.

- **`$TUGBOAT_PREVIEW_SHA`** - The git SHA that the preview was built from.

- **`$TUGBOAT_PROJECT_ID`** - The ID of the project that the current Preview belongs to.

- **`$TUGBOAT_PROJECT`** - The friendly name of the project that the current Preview belongs to.

- **`$TUGBOAT_REPO_ID`** - The ID of the repo that the current Preview belongs to.

- **`$TUGBOAT_REPO`** - The friendly name of the repo that the current Preview belongs to.

- **`$TUGBOAT_ROOT`** - The filesystem location where the git repository is cloned.

- **`$TUGBOAT_SERVICE_ID`** - The ID of the current service.

- **`$TUGBOAT_SERVICE`** - The friendly name of the current Service. This is also the hostname used to reference this
  Service container from other Services.

- **`$TUGBOAT_SMTP`** - The hostname of a Tugboat SMTP server that can be used to capture outbound email from the
  Preview.

## Exposed Service Variables

If a Service has an exposed HTTP port configured, the following variables are also available with information about the
Service's public URL

- **`$TUGBOAT_SERVICE_TOKEN`** - The authentication token for the Tugboat Service. This is used by the Tugboat HTTP
  proxy to grant access to a Service and is passed through mostly as an informational value. Additional verification
  could be done in the application if necessary.

- **`$TUGBOAT_SERVICE_URL`** - The full URL of the current Service.

- **`$TUGBOAT_SERVICE_URL_PROTOCOL`** - The "protocol" part of the current service's URL.

- **`$TUGBOAT_SERVICE_URL_HOST`** - The "host" part of the current service's URL.

- **`$TUGBOAT_SERVICE_URL_PATH`** - The "path" part of the current service's URL.

- **`$TUGBOAT_SERVICE_CONFIG_ALIASES`** - A comma-separated list of aliases configured for the current service.

- **`$TUGBOAT_SERVICE_CONFIG_DOMAIN`** - The configured domain for the current service.

## Base Preview Environment Variables

If a Preview was built from a Base Preview, the following variables are also available with information about the Base
Preview.

- **`$TUGBOAT_BASE_PREVIEW`** - The friendly name of the Base Preview.

- **`$TUGBOAT_BASE_PREVIEW_ID`** - The ID of the Base Preview.

- **`$TUGBOAT_BASE_PREVIEW_TOKEN`** - The authentication token of the Base Preview's default Service.

- **`$TUGBOAT_BASE_PREVIEW_URL`** - The public URL for the Base Preview's default Service.

- **`$TUGBOAT_BASE_PREVIEW_URL_PROTOCOL`** - The "protocol" part of the Base Preview's default Service URL.

- **`$TUGBOAT_BASE_PREVIEW_URL_HOST`** - The "host" part of the Base Preview's default Service URL.

- **`$TUGBOAT_BASE_PREVIEW_URL_PATH`** - The "path" part of the Base Preview's default Service URL.

## Provider-specific Environment Variables

### Bitbucket

These variables are injected into Tugboat Previews that are built from a Bitbucket repository.

- **`$TUGBOAT_BITBUCKET_OWNER`** - The owner of the Bitbucket repository.

- **`$TUGBOAT_BITBUCKET_SLUG`** - The URL-friendly name of the Bitbucket repository. See
  https://confluence.atlassian.com/bitbucket/what-is-a-slug-224395839.html

These variables are only injected into Tugboat Previews that are built from a Bitbucket pull request.

- **`$TUGBOAT_BITBUCKET_PR`** - The Bitbucket pull request number.

- **`$TUGBOAT_BITBUCKET_TITLE`** - The title of the Bitbucket pull request.

* **`$TUGBOAT_BITBUCKET_SOURCE`** - The name of the pull request source branch.

* **`$TUGBOAT_BITBUCKET_DESTINATION`** - The name of the pull request destination branch.

### Git

These variables are injected into Tugboat Previews that are built from a raw git repository.

- **`$TUGBOAT_GIT_REPO`** - The address of the git repository.

### GitHub

These variables are injected into Tugboat Previews that are built from a GitHub repository.

- **`$TUGBOAT_GITHUB_OWNER`** - The owner of the GitHub repository.

- **`$TUGBOAT_GITHUB_REPO`** - The name of the GitHub repository.

These variables are only injected into Tugboat Previews that are built from a GitHub pull request.

- **`$TUGBOAT_GITHUB_PR`** - The GitHub pull request number.

- **`$TUGBOAT_GITHUB_TITLE`** - The title of the GitHub pull request.

* **`$TUGBOAT_GITHUB_HEAD`** - The name of the pull request head branch.

* **`$TUGBOAT_GITHUB_BASE`** - The name of the pull request base branch.

### GitLab

These variables are injected into Tugboat Previews that are built from a GitLab repository.

- **`$TUGBOAT_GITLAB_NAMESPACE`** - The namespace of the GitLab repository.

- **`$TUGBOAT_GITLAB_PROJECT`** - The project name of the GitLab repository.

These variables are only injected into Tugboat Previews that are built from a GitLab merge request.

- **`$TUGBOAT_GITLAB_MR`** - The GitLab merge request number.

- **`$TUGBOAT_GITLAB_TITLE`** - The title of the GitLab merge request.

* **`$TUGBOAT_GITLAB_SOURCE`** - The name of the merge request source branch.

* **`$TUGBOAT_GITLAB_TARGET`** - The name of the merge request target branch.

### Stash / Bitbucket Server

These variables are injected into a Tugboat Previews that are built from a Stash or Bitbucket Server repository.

- **`$TUGBOAT_STASH_PROJECT`** - The project where the repository lives.

- **`$TUGBOAT_STASH_SLUG`** - The URL-friendly name of the repository. See
  https://confluence.atlassian.com/bitbucket/what-is-a-slug-224395839.html

These variables are only injected into Tugboat Previews that are built from a Stash or Bitbucket Server pull request.

- **`$TUGBOAT_STASH_PR`** - The pull request number.

- **`$TUGBOAT_STASH_TITLE`** - The title of the pull request.

* **`$TUGBOAT_STASH_SOURCE`** - The name of the pull request source branch.

* **`$TUGBOAT_STASH_DESTINATION`** - The name of the pull request destination branch.
