# Automate Previews

We love automatically generating Previews from new pull requests - we think it's
one of Tugboat's best features!

- [What are the options for auto-generating Previews?](#options-for-auto-generating-previews)
- [How to configure Tugboat to auto-generate Previews](#auto-generate-previews)

### Options for auto-generating Previews

If you're using a
[git provider integration](../../setting-up-tugboat/index.md#connect-with-your-provider),
you'll be able to auto-generate Previews in a few different ways:

- **Build Pull Requests Automatically**  
  Tugboat automatically creates a Preview when a pull request is opened.
- **Rebuild Updated Pull Requests Automatically**  
  Tugboat automatically rebuilds a Preview when the corresponding pull request
  is updated.
- **Build Previews for Forked Pull Requests**  
  Tugboat builds Previews for pull requests made to the primary repo from forked
  repositories. **There are security implications from using this setting:** any
  secrets in your Preview will be accessible by the owner of the forked
  repository.

Besides auto-generating Previews from pull requests, you can also auto-generate
Previews when you make changes to a [Base Preview](#set-a-base-preview). If
you've [set a Base Preview](#how-to-set-a-base-preview), you can have Tugboat:

- **Rebuild Orphaned Previews Automatically** Automatically rebuild Previews
  when the Base Preview they were built from is [rebuilt](#rebuild).
- **Rebuild Stale Previews Automatically** Automatically rebuild Previews when
  the Base Preview they were built from is [refreshed](#refresh).

### Auto-generate Previews

To configure Tugboat to auto-generate Previews, you'll need to:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to configure auto-generate settings for
   Previews.
3. Click into Settings for the repository.
4. Click the checkboxes for the auto-generate features you'd like to turn
   on/off.

> ####Hint::Missing auto-generate from PR options?
>
> Don't see the options to auto-generate Previews from pull requests? You'll
> need to
> [connect your preferred git provider to Tugboat](../../setting-up-tugboat/index.md#connect-with-your-provider),
> and then [delete](../../setting-up-tugboat/index.md#delete-the-repo) and
> [re-add the provider-specific version of the repository](../../setting-up-tugboat/index.md#add-repos-to-the-project)
> to your Tugboat project.

## Auto-delete Previews

Each of the Previews in your Tugboat project count toward the total storage
space available in your project's billing tier. By default, Tugboat is
configured to automatically delete Previews when their corresponding git pull
requests are merged or closed.

If you want to manually change the setting to automatically delete Previews when
their PRs are merged or closed:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to configure auto-delete settings for
   Previews.
3. Click into Settings for the repository.
4. Click the checkbox to change the setting.

## Auto-update Previews
