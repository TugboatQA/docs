# Pantheon

These instructions show how to configure Tugboat for a typical Pantheon-hosted
site. While the instructions below are for a Drupal 8 site hosted on Pantheon,
the concepts should apply for any Pantheon hosted PHP site. Check out the
[Drupal7](../drupal7/index.md) or [WordPress](../wordpress/index.md) examples to
compare with.

> #### Warning::Git provider
> The following instructions assume you are using a git repository provider such
> as GitHub, GitLab, or BitBucket. Pantheon has [documentation on how to use
> GitHub](https://pantheon.io/docs/guides/build-tools/), but if that's not an
> option, [connect with us](/support/index.md) to learn how to wire directly to
> Pantheon.

An overview of the steps you will need to perform:

1. Create a Tugboat project (instructions below).
2. [Choose appropriate Tugboat services](add-services/index.md).
3. [Create a Pantheon terminus token and add it to Tugboat](configure-terminus/index.md).
4. [Add a Makefile build script](add-build-script/index.md) to your project.

If you're feeling confident that you don't need to go step by step, you can
download the [full Pantheon Makefile](full-makefile/index.md) and tweak it yourself. 

## 1. Create a Tugboat project

To start with, [create a new Tugboat project](../../getting-started/create-a-project/index.md). 
If you already have a project, [add your repository](../../tugboat-dashboard/repositories/index.md)
to it and then navigate to the [repository settings](../../tugboat-dashboard/repositories/settings/index.md)
to [add your services](add-services/index.md).

#### Next: [Add your services](add-services/index.md)
