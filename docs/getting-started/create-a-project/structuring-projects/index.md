Most often, if you just have one repository that you want to use Tugboat with,
just create a project that correlates directly to that repository. If it's a
little more complicated than that, read on.

A Tugboat Project can contain any number of repositories that you want Tugboat
to build previews for, and is tied to a subscription model (free or premium).
Additionally, you can invite users to join a project. It can be helpful to think
about how to break up your projects based on these three questions:

1. What repositories are a part of this project? (Often this is just one)
2. Who will I want to be able to access the Tugboat dashboard for those
   repositories?
3. What subscription model will the project need? Or put another way, what sort
   of Tugboat resources (how much memory and disk space) do I expect this
   project to use?

Based on these answers, you may realize that you want to break things up into
more projects, or alternately combine several repositories into a single
project.

For example, let's say you are building a recipe site that consists of a backend
Drupal repository and a frontend React repository. If the entire development
team should have access to both repositories within Tugboat, you probably should
create a single project for both repositories in Tugboat.

On the other hand, let's say you have a simple WordPress blog that is managed by
an outside vendor, and a separate and unrelated NodeJS application that is a
"top secret" internal project your company is working on. It's best to create
two separate projects so that you can keep that top secret project from prying
eyes.
