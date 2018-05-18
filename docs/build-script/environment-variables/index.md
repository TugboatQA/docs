# Environment Variables

Tugboat injects the following environment variables into every container, which
you can use for anything from build scripts to application configuration, etc.
These variables are available for the entire lifetime of a Preview's container.
This includes both build-time as well as run-time. So, they can be used in Build
Scripts as well as run-time configuration files, etc.

* **`$TUGBOAT_DASHBOARD`** - The domain where the Tugboat Dashboard can be
  found.

* **`$TUGBOAT_DOMAIN`** - The root domain of the current Tugboat Preview

* **`$TUGBOAT_IMAGE`** - DEPRECATED. Use `$TUGBOAT_SERVICE` instead.

* **`$TUGBOAT_PREVIEW_ID`** - The ID of the current preview.

* **`$TUGBOAT_PREVIEW`** - The friendly name of the current preview.

* **`$TUGBOAT_PROJECT_ID`** - The ID of the project that the current preview
  belongs to.

* **`$TUGBOAT_PROJECT`** - The friendly name of the project that the current
  preview belongs to.

* **`$TUGBOAT_PROXY_URL`** - One of `subdomain` or `subpath`. This specifies
  what the URL looks like for the current preview.

* **`$TUGBOAT_REPO_ID`** - The ID of the repo that the current preview belongs
  to.

* **`$TUGBOAT_REPO`** - The friendly name of the repo that the current preview
  belongs to.

* **`$TUGBOAT_ROOT`** - The filesystem location where the git repository is
  cloned.

* **`$TUGBOAT_SERVICE_ID`** - The ID of the current service.

* **`$TUGBOAT_SERVICE`** - The friendly name of the current service. This is
  also the hostname used to reference this service container from other
  services.

* **`$TUGBOAT_SMTP`** - The hostname of a Tugboat SMTP server that can be used
  to capture outbound email from the preview.

* **`$TUGBOAT_TAG`** - DEPRECATED. Use `$TUGBOAT_PREVIEW` instead.

* **`$TUGBOAT_TOKEN`** - The authentication token for the current Tugboat
  Preview. This is used by the Tugboat HTTP proxy to grant access to a Preview
  and is passed through mostly as an informational value. Additional
  verification could be done in the application if necessary.

* **`$TUGBOAT_URL`** - The URL for the Tugboat Preview.

## Base Preview Environment Variables

If a Preview was built from a Base Preview, the following variables are also
available with information about the base preview.

* **`TUGBOAT_BASE_PREVIEW`** - The friendly name of the Base Preview.

* **`TUGBOAT_BASE_PREVIEW_ID`** - The ID of the Base Preview.

* **`TUGBOAT_BASE_PREVIEW_TOKEN`** - The authentication token for the Base
  Preview.

* **`TUGBOAT_BASE_PREVIEW_URL`** - The public URL for the Base Preview.

## Provider-specific Environment Variables

### Bitbucket

These variables are injected into Tugboat Previews that are built from a
Bitbucket repository.

* **`$TUGBOAT_BITBUCKET_OWNER`** - The owner of the Bitbucket repository.

* **`$TUGBOAT_BITBUCKET_SLUG`** - The URL-friendly name of the Bitbucket
  repository. See
  https://confluence.atlassian.com/bitbucket/what-is-a-slug-224395839.html

These variables are only injected into Tugboat Previews that are built from a
Bitbucket pull request.

* **`$TUGBOAT_BITBUCKET_TITLE`** - The title of the Bitbucket pull request.

* **`$TUGBOAT_BITBUCKET_SOURCE`** - The name of the pull request source branch.

* **`$TUGBOAT_BITBUCKET_DESTINATION`** - The name of the pull request
  destination branch.

### Git

These variables are injected into Tugboat Previews that are built from a raw git
repository.

* **`$TUGBOAT_GIT_REPO`** - The address of the git repository.

### Github

These variables are injected into Tugboat Previews that are built from a Github
repository.

* **`$TUGBOAT_GITHUB_OWNER`** - The owner of the Github repository.

* **`$TUGBOAT_GITHUB_REPO`** - The name of the Github repository.

These variables are only injected into Tugboat Previews that are built from a
Github pull request.

* **`$TUGBOAT_GITHUB_TITLE`** - The title of the Github pull request.

* **`$TUGBOAT_GITHUB_HEAD`** - The name of the pull request head branch.

* **`$TUGBOAT_GITHUB_BASE`** - The name of the pull request base branch.

### Gitlab

These variables are injected into Tugboat Previews that are built from a Gitlab
repository.

* **`$TUGBOAT_GITLAB_NAMESPACE`** - The namespace of the Gitlab repository.

* **`$TUGBOAT_GITLAB_PROJECT`** - The project name of the Gitlab repository.

These variables are only injected into Tugboat Previews that are built from a
Gitlab merge request.

* **`$TUGBOAT_GITLAB_TITLE`** - The title of the Gitlab merge request.

* **`$TUGBOAT_GITLAB_SOURCE`** - The name of the merge request source branch.

* **`$TUGBOAT_GITLAB_TARGET`** - The name of the merge request target branch.

### Stash / Bitbucket Server

These variables are injected into a Tugboat Previews that are built from a Stash
or Bitbucket Server repository.

* **`$TUGBOAT_STASH_PROJECT`** - The project where the repository lives.

* **`$TUGBOAT_STASH_SLUG`** - The URL-friendly name of the repository. See
  https://confluence.atlassian.com/bitbucket/what-is-a-slug-224395839.html

These variables are only injected into Tugboat Previews that are built from a
Stash or Bitbucket Server pull request.

* **`$TUGBOAT_STASH_TITLE`** - The title of the pull request.

* **`$TUGBOAT_STASH_SOURCE`** - The name of the pull request source branch.

* **`$TUGBOAT_STASH_DESTINATION`** - The name of the pull request destination
  branch.
