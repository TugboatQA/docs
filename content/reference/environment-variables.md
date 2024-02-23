---
title: "Environment Variables"
date: 2019-09-17T11:26:07-04:00
weight: 5
---

This page covers Tugboat's environment variables. If you're looking for information on how to use custom environment
variables with Tugboat, see:
[Create Custom Environment Variables](/setting-up-services/how-to-set-up-services/custom-environment-variables).

- [Tugboat Environment Variables](#tugboat-environment-variables)
- [Exposed Service Variables](#exposed-service-variables)
- [Base Preview Environment Variables](#base-preview-environment-variables)
- [Image-specific Environment Variables](#image-specific-environment-variables)
- [Provider-specific environment variables](#provider-specific-environment-variables)
  - [Bitbucket](#bitbucket)
  - [Git](#git)
  - [GitHub](#github)
  - [GitLab](#gitlab)
  - [Stash/Bitbucket Server](#stash-bitbucket-server)



## Image-specific Environment Variables

These variables are added to some of [Tugboat's images](/reference/tugboat-images).

- **`$DOCROOT`** - On images that provide a webserver (such as `tugboatqa/httpd`, `tugboatqa/nginx`, or `tugboatqa/php`
  images that have Apache installed), the `$DOCROOT` environment variable points to the full path that Tugboat expects
  your document root to live. It's recommended to symlink your assets directory into place: e.g.
  `ln -snf "${TUGBOAT_ROOT}/build" "${DOCROOT}"`.

## Provider-specific Environment Variables

### Bitbucket

These variables are injected into Tugboat Previews that are built from a Bitbucket repository.

- **`$TUGBOAT_BITBUCKET_OWNER`** - The owner of the Bitbucket repository.  
  _**Ex:**_ ``

- **`$TUGBOAT_BITBUCKET_SLUG`** - The URL-friendly name of the Bitbucket repository. See
  https://confluence.atlassian.com/bitbucket/what-is-a-slug-224395839.html

These variables are only injected into Tugboat Previews that are built from a Bitbucket pull request.  
  _**Ex:**_ ``

- **`$TUGBOAT_BITBUCKET_PR`** - The Bitbucket pull request number.  
  _**Ex:**_ ``

- **`$TUGBOAT_BITBUCKET_TITLE`** - The title of the Bitbucket pull request.  
  _**Ex:**_ ``

* **`$TUGBOAT_BITBUCKET_SOURCE`** - The name of the pull request source branch.  
  _**Ex:**_ ``

* **`$TUGBOAT_BITBUCKET_DESTINATION`** - The name of the pull request destination branch.  
  _**Ex:**_ ``

### Git

These variables are injected into Tugboat Previews that are built from a raw git repository.

- **`$TUGBOAT_GIT_REPO`** - The address of the git repository.  
  _**Ex:**_ ``

### GitHub

These variables are injected into Tugboat Previews that are built from a GitHub repository.

- **`$TUGBOAT_GITHUB_OWNER`** - The owner of the GitHub repository.  
  _**Ex:**_ ``

- **`$TUGBOAT_GITHUB_REPO`** - The name of the GitHub repository.  
  _**Ex:**_ ``

These variables are only injected into Tugboat Previews that are built from a GitHub pull request.

- **`$TUGBOAT_GITHUB_PR`** - The GitHub pull request number.  
  _**Ex:**_ ``

- **`$TUGBOAT_GITHUB_TITLE`** - The title of the GitHub pull request.  
  _**Ex:**_ ``

* **`$TUGBOAT_GITHUB_HEAD`** - The name of the pull request head branch.  
  _**Ex:**_ ``

* **`$TUGBOAT_GITHUB_BASE`** - The name of the pull request base branch.  
  _**Ex:**_ ``

### GitLab

These variables are injected into Tugboat Previews that are built from a GitLab repository.

- **`$TUGBOAT_GITLAB_NAMESPACE`** - The namespace of the GitLab repository.  
  _**Ex:**_ ``

- **`$TUGBOAT_GITLAB_PROJECT`** - The project name of the GitLab repository.  
  _**Ex:**_ ``

These variables are only injected into Tugboat Previews that are built from a GitLab merge request.

- **`$TUGBOAT_GITLAB_MR`** - The GitLab merge request number.  
  _**Ex:**_ ``

- **`$TUGBOAT_GITLAB_TITLE`** - The title of the GitLab merge request.  
  _**Ex:**_ ``

* **`$TUGBOAT_GITLAB_SOURCE`** - The name of the merge request source branch.  
  _**Ex:**_ ``

* **`$TUGBOAT_GITLAB_TARGET`** - The name of the merge request target branch.  
  _**Ex:**_ ``

### Stash / Bitbucket Server

These variables are injected into a Tugboat Previews that are built from a Stash or Bitbucket Server repository.

- **`$TUGBOAT_STASH_PROJECT`** - The project where the repository lives.  
  _**Ex:**_ ``

- **`$TUGBOAT_STASH_SLUG`** - The URL-friendly name of the repository. See
  https://confluence.atlassian.com/bitbucket/what-is-a-slug-224395839.html

These variables are only injected into Tugboat Previews that are built from a Stash or Bitbucket Server pull request.

- **`$TUGBOAT_STASH_PR`** - The pull request number.  
  _**Ex:**_ ``

- **`$TUGBOAT_STASH_TITLE`** - The title of the pull request.  
  _**Ex:**_ ``

* **`$TUGBOAT_STASH_SOURCE`** - The name of the pull request source branch.  
  _**Ex:**_ ``

* **`$TUGBOAT_STASH_DESTINATION`** - The name of the pull request destination branch.
