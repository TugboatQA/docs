<img alt="Tugboat logo" src="logo.png" width="200px" style="padding: 0; border: none">

Tugboat is a system that builds a working preview of a website for any git
branch, tag, commit, or pull request. It can automatically create these previews
for pull requests by integrating with GitHub, GitLab, or Bitbucket git
repositories.

## Contributing

If you have any suggestions or feedback about this documentation, we are happy
to hear it. We want this document to be as helpful as possible. Email us at
[support@tugboat.qa](mailto:support@tugboat.qa) or
[open an issue](https://github.com/TugboatQA/docs/issues/new) on our GitHub
repository.

## Terminology and Definitions

The following terms are used throughout this document

* **Provider** - A provider is where your git repository is hosted. This usually
  refers to GitHub, GitLab, or Bitbucket. This document refers to each of these
  generically as a "provider".

* **Pull Request** - Most of the providers supported by Tugboat support the
  concept of a pull request. This is a method of requesting that new code be
  merged into a branch in the git repository. The terminology between providers
  sometimes differs. For example, GitLab calls these "merge requests". For
  consistency, this document refers to this feature as a "pull request".

* **Project** - A Tugboat Project is an organizational unit. It can contain any
  number of Tugboat Repositories. Each of these Tugboat Repositories share the
  disk quota and other resource limits set on the Tugboat Project. A user can
  have access to any number of Tugboat Projects. Likewise, any number of users
  can be given access to a Tugboat Project. This document may refer to a Tugboat
  Project as either "Tugboat Project" or sometimes just "project", whichever
  fits the context.

* **Repository** - A Tugboat Repository is linked to a git repository at one of
  the supported providers. The distinction between a Tugboat Repository and a
  git repository is sometimes subtle, so this document will show the difference
  by using "Tugboat Repository" or "git repository" when clarification is
  needed.

* **Preview** - A Tugboat Preview belongs to a specific Tugboat Repository, and
  is an isolated instance of the website represented by the git repository
  linked to that Tugboat Repository. A Preview is built from a specific branch,
  tag, commit, or pull request from the git repository, and is given a unique
  URL. This document may refer to a Tugboat Preview as either "Tugboat Preview"
  or sometimes just "preview", whichever fits the context.

* **Base Preview** - A Base Preview is a preview that acts as a starting point
  for another preview to be built from. Using a base preview typically reduces
  the time required to build a preview as well as the amount of disk space
  required for that preview. Any preview can be a base preview. See
  [Base Previews](features/base-previews/index.md) for more details. This
  document refers to this feature as "base preview".

* **Service** - A Tugboat Service is a building block of a preview. Each service
  represents a server in the infrastructure required to serve a website. Every
  preview consists of one or more services, one of which is responsible for
  serving the website via HTTP. This document refers to a Tugboat Service as
  either "Tugboat Service" or just "service", whichever fits the context.
