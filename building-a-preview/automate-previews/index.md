# Automate Previews

We love automatically generating Previews from new pull requests - we think it's
one of Tugboat's best features! If you're using a
[git provider integration](../../setting-up-tugboat/index.md#connect-with-your-provider),
you'll be able to automate Preview actions in a few different ways:

- [Auto-generate Previews](#auto-generate-previews)
- [Auto-update Previews](#auto-update-previews)
- [Auto-delete Previews](#auto-delete-previews)

## Auto-generate Previews

Tugboat provides two ways to automatically generate Previews when pull requests
are made:

**Build Pull Requests Automatically**

Tugboat automatically creates a Preview when a pull request is opened.

**Build Previews for Forked Pull Requests**

Tugboat builds Previews for pull requests made to the primary repo from forked
repositories.

> #### Warning:: There are security implications when using this setting
>
> Any secrets in your Preview will be accessible by the owner of the forked
> repository.

### To set Tugboat to automatically Build Previews

To configure Tugboat to auto-generate Previews, you'll need to:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to configure auto-generate settings for
   Previews.
3. Click into **Settings** for the repository.
4. Click the checkboxes for the auto-generate features you'd like to turn
   on/off.
5. Press the Save Configuration button to save your changes.

> ####Hint::Missing auto-generate from PR options?
>
> Don't see the options to auto-generate Previews from pull requests? You'll
> need to
> [connect your preferred git provider to Tugboat](../../setting-up-tugboat/index.md#connect-with-your-provider),
> and then [delete](../../setting-up-tugboat/index.md#delete-the-repo) and
> [re-add the provider-specific version of the repository](../../setting-up-tugboat/index.md#add-repos-to-the-project)
> to your Tugboat project.

#### Visual Walkthrough

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

Select the project where you want to configure auto-generate settings for
Previews.

Click into **Settings** for the repository.

Click the checkboxes for the auto-generate features you'd like to turn on/off.

Press the Save Configuration button to save your changes.

## Auto-update Previews

You can set Tugboat to automatically update Previews in a couple of different
ways. First is the most straightforward:

**Rebuild Updated Pull Requests Automatically**

When you select this setting, Tugboat automatically rebuilds a Preview when the
corresponding pull request is updated.

Besides auto-generating Previews from pull requests, you can also auto-generate
Previews when you make changes to a Base Preview. If you've
[set a Base Preview](../work-with-base-previews/index.md#how-to-set-a-base-preview),
you can have Tugboat:

**Rebuild Orphaned Previews Automatically**

Automatically rebuild Previews when the Base Preview they were built from is
[rebuilt](../work-with-base-previews/index.md#change-a-base-preview).

**Rebuild Stale Previews Automatically**

Automatically rebuild Previews when the Base Preview they were built from is
[refreshed](../work-with-base-previews/index.md#update-a-base-preview).

### To set Tugboat to automatically update Previews

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to configure auto-update settings for
   Previews.
3. Click into **Settings** for the repository.
4. Click the checkboxes to change the settings you want to adjust.
5. Press the Save Configuration button to save your changes.

#### Visual Walkthrough

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

Select the project where you want to configure auto-update settings for
Previews.

Click into **Settings** for the repository.

Click the checkboxes to change the settings you want to adjust.

Press the Save Configuration button to save your changes.

## Auto-delete Previews

Each of the Previews in your Tugboat project count toward the total storage
space available in your
[project's billing tier](../../tugboat-billing/index.md). By default, Tugboat is
configured to automatically delete Previews when their corresponding git pull
requests are merged or closed.

### To automatically delete Previews:

If you want to change the setting to automatically delete Previews when their
PRs are merged or closed:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to configure auto-delete settings for
   Previews.
3. Click into **Settings** for the repository.
4. Click the checkbox to change the setting.
5. Press the Save Configuration button to save your changes.

#### Visual Walkthrough

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
upper-right of the Tugboat screen.

Select the project where you want to configure auto-delete settings for
Previews.

Click into **Settings** for the repository.

Click the checkbox to change the setting.

Press the Save Configuration button to save your changes.
