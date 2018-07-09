# Tugboat Previews

A Tugboat Preview is an isolated instance of the website represented by a
[repository](../repositories/index.md). A preview can represent the code found
in a branch, tag, commit, or pull request of a git repository, and is built from
one or more [services](../services/index.md).

Each preview is given a unique URL, which can be shared with anyone. That URL
routes to the default [service](../services/index.md) of the preview, which is
defined in the parent [repository](../repositories/index.md)
[configuration file](../../configuring-tugboat/index.md#default-service).

Based on the configuration of the parent [repository](../repositories/index.md),
previews for pull requests can be created automatically. They can also be
updated automatically if new commits are pushed, and deleted automatically when
merged or otherwise closed.

Previews for branches or tags must be managed manually.
