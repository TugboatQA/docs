---
title: "Select Repo Settings"
date: 2019-09-17T11:42:15-04:00
weight: 4
---

After you've created a project, you might want to go in and tweak your Tugboat
repo settings. When you go into Repository Settings, you can:

- [Modify settings for your GitHub, GitLab, or Bitbucket integration](#modify-settings-for-your-github-gitlab-or-bitbucket-integration)
- [Rebuild Orphaned Previews Automatically](#rebuild-orphaned-previews-automatically)
- [Rebuild Stale Previews Automatically](#rebuild-stale-previews-automatically)
- [Refresh Base Previews Automatically](#refresh-base-previews-automatically)
- [Specify Build Timeout](#specify-build-timeout)
- [Modify Environment Variables](#modify-environment-variables)
- [Set up Remote SSH Access](#set-up-remote-ssh-access)
- [Authenticate with a Docker Registry](#authenticate-with-a-docker-registry)
- [Delete the repo](#delete-the-repository)

Don't forget to hit the {{% ui-text %}}Save Configuration{{% /ui-text %}} button
after you've checked or unchecked boxes to save your changes.

If you later need to change Repository Settings, you can do that anytime; see:
[Change Repository Settings](#change-repository-settings).

### Modify settings for your GitHub, GitLab or Bitbucket Integration

When you're using the Tugboat integration with GitHub, GitLab or Bitbucket,
you'll see provider-specific settings for each of your Tugboat repos. These
settings enable you to do things like automatically create a Preview when a Pull
Request or Merge Request is opened, or post a comment to a PR with links to its
Preview. For a full list of the provider-specific integration options, check
out:

- [Using the GitHub integration](../connect-with-your-provider/#using-the-github-integration)
- [Using the GitLab integration](../connect-with-your-provider/#using-the-gitlab-integration)
- [Using the BitBucket integration](../connect-with-your-provider/#using-the-bitbucket-integration)

### Rebuild Orphaned Previews Automatically

When this option is selected, Tugboat automatically
[rebuilds Previews](/building-a-preview/automate-previews/auto-update/) when the
[Base Preview](/building-a-preview/work-with-base-previews/set-a-base-preview/)
they're built from is
[rebuilt](/building-a-preview/work-with-base-previews/change-or-update/). This
option is turned off by default.

### Rebuild Stale Previews Automatically

When this option is selected, Tugboat automatically
[rebuilds Previews](/building-a-preview/automate-previews/auto-update/) when the
[Base Preview](/building-a-preview/work-with-base-previews/set-a-base-preview/)
they're built from is
[refreshed](/building-a-preview/work-with-base-previews/change-or-update/#update-a-base-preview).
This option is turned off by default.

To unpack this a little:

- When you're using a
  [Base Preview](/building-a-preview/work-with-base-previews/set-a-base-preview)
- And the Base Preview is
  [refreshed](/building-a-preview/work-with-base-previews/change-or-update/#update-a-base-preview)  
  (You may manually Refresh a Base Preview, or have Tugboat
  [refresh Base Previews automatically](#refresh-base-previews-automatically),
  for example, every day at 12am UTC.)
- The Base Preview kicks off the
  [build process](/building-a-preview/preview-deep-dive/how-previews-work/#the-build-process-explained)
  from the `update` phase, and runs commands in both `update` and `build`
- When the Base Preview refresh is complete, child Previews kick off a build
  process from `build`, using the Base Preview as the starting point and
  bypassing commands in `init` and `update`.

### Refresh Base Previews Automatically

By default, Tugboat refreshes your Base Previews every day at 12am UTC. You can
de-select this checkbox to turn off automatic refresh, or you can specify your
preferred interval and time for the refresh to occur. Automatically refreshing
Base Previews is a great way to ensure your large assets, such as databases,
stay up-to-date, saving you time when you build a new Preview from a
recently-refreshed Base Preview.

### Specify Build Timeout

By default, Preview builds timeout at 3600 seconds. You can change the Preview
build timeout to your preferred interval.

### Modify Environment Variables

Here's where you can enter environment variables, like API keys or passwords,
that you wouldn't want to store in your repo. If you're looking for Tugboat's
environment variables to add to your Build Scripts or configuration files, check
out [Reference -> Environment Variables](/reference/environment-variables).

### Set up Remote SSH Access

SSH commands that you run from Previews in this repository use the public key in
your repo settings. Each of your repositories linked to Tugboat have a unique
SSH key. Put this public key on the remote servers that your build scripts or
applications need to access.

- [Use the Tugboat SSH key](#use-the-tugboat-ssh-key)
- [Delete an SSH key](#delete-an-ssh-key)

{{% notice info %}} You can't SSH into a Tugboat Preview; the SSH key here is
all about outbound requests to remote resources. If you want to get _into_ a
Tugboat Preview, shell access is provided in both the web interface and the
[command line tool](/tugboat-cli/). {{% /notice %}}

#### Use the Tugboat SSH key

When you link a git repository to Tugboat, Tugboat automatically generates an
SSH key for that repo. You can access this key in
[Repository Settings](#change-repository-settings); scroll to the
{{% ui-text %}}Remote SSH Access{{% /ui-text %}} option. To use the SSH key,
simply copy it to your clipboard and put it where you need it!

![Copy SSH Key to Clipboard](../../_images/remote-ssh-access-copy-ssh-key.png)

{{% notice info %}} Tugboat provides a private 4096 bit length RSA SSH key. What
you see on the Repository Settings page is the public key from the pair.
{{% /notice %}}

If you want Tugboat to generate a new SSH key, press the {{% ui-text %}}Generate
SSH Key{{% /ui-text %}} button. You'll see a dialog box asking you to confirm
that you want to generate a new key, as this action can't be undone.

{{% notice warning %}} If you have Tugboat create a new SSH key, this
automatically erases the existing SSH key. If you're using this SSH key
anywhere, you'll need to update that when you generate a new key.
{{% /notice %}}

#### Delete an SSH key

Need to delete or get rid of an SSH key? Go to
[Repository Settings](#change-repository-settings); scroll to the
{{% ui-text %}}Remote SSH Access{{% /ui-text %}} option for the repository whose
key you want to delete, and press the {{% ui-text %}}Generate SSH
Key{{% /ui-text %}} button. Generating a new key permanently erases the old key.

### Authenticate with a Docker Registry

If you want to pull images from Docker registries that require authentication,
you can manage your authorization credentials from within the repo settings.

![Authenticate with a Docker registry](../../_images/authenticate-with-a-docker-registry-add-credentials.png)

### Delete the Repository

If you want to delete a repo from your Tugboat project, you'll go into the
Repository Settings for that repo and press the {{% ui-text %}}Delete
Repository{{% /ui-text %}} button. Deleting a repo from Tugboat does not affect
any data in the git provider repo connected to it, nor does it delete the
Tugboat project that contains the repo.

![Delete repository](../../_images/delete-repository.png)

{{% notice note %}} Only Admin users have the **Delete Repository** option. For
more on user permissions, see:
[User permission levels explained](/administer-tugboat-crew/user-admin/#user-permission-levels-explained).
{{% /notice %}}

### Change Repository Settings

Any time you need to make a change to Repository Settings:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to edit repository settings.
3. Scroll to the linked repository whose settings you want to change, and click
   the {{% ui-text %}}Settings{{% /ui-text %}} link.

From here, you'll see all the Repository Settings you can modify. If you make
changes to the settings, don't forget to press the {{% ui-text %}}Save
Configuration{{% /ui-text %}} button!
