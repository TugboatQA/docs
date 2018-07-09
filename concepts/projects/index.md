# Tugboat Projects

Tugboat Projects provide a way to organize a set of related repositories. How
these repositories are related is subjective, and may differ from project to
project. A Project can contain any number of
[repositories](../repositories/index.md), and can be shared with multiple users.

Each project is given a disk quota, which is shared between all of its
[repositories](../repositories/index.md). In addition, a project's settings
define how much CPU and RAM is allocated for every
[service](../services/index.md) created for that project, as well as how long a
[preview](../previews/index.md) can be idle before being suspended.

Billing is done at the project level, so the [tier](https://tugboat.qa/pricing)
that a project is subscribed to determines each of the above limits.

## Structuring Projects

If you only have one git repository that you want to use with Tugboat, create a
project that correlates directly to that repository. If it's a little more
complicated than that, read on.

A Tugboat Project can contain any number of repositories. Additionally, you can
invite users to join a project. It can be helpful to think about how to break up
your projects based on these three questions:

1.  Which repositories are a part of this project?
2.  Who will access the Tugboat dashboard for those repositories?
3.  What sort of Tugboat resources (memory, disk space, etc.) do you expect this
    project to use?

Based on these answers, you may realize that you want to break things up into
multiple projects, or combine several repositories into a single project.

For example, let's say you are building a recipe site that consists of a backend
Drupal repository and a frontend React repository. If the entire development
team should have access to both repositories within Tugboat, you probably should
create a single project for both repositories in Tugboat.

On the other hand, let's say you have a simple WordPress blog that is managed by
an outside vendor. Also, you have a separate and unrelated NodeJS application
that is a "top secret" internal project your company is working on. It may be
best to create two separate projects so that you can manage permissions for each
of the projects independently.
