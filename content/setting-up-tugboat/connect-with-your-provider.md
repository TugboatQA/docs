---
title: "Connect With Your Provider"
date: 2019-09-17T11:41:29-04:00
lastmod: 2020-04-17T17:00:00-04:00
weight: 1
---

- [GitHub](#github)
- [GitLab](#gitlab)
- [Bitbucket](#bitbucket)
- [Generic git server](#generic-git-server)
- [Add a link to an additional git provider](#adding-a-link-to-a-git-provider)
- [Disconnect a linked git provider](#disconnect-a-linked-git-provider)

## GitHub

- [How to connect Tugboat to GitHub](#how-do-i-link-tugboat-to-github)
- [Using the GitHub integration](#using-the-github-integration)

### How do I link Tugboat to GitHub?

1. Go to [Sign In](https://dashboard.tugboat.qa/) and select GitHub.
2. Enter your GitHub Username and Password (or Create an Account), complete Two-Factor Authentication.
3. Authorize Tugboat.

Once you complete GitHub authorization, you'll be redirected to the [Create a Tugboat Project](../create-a-new-project/)
screen.

{{%expand "Visual Walkthrough" %}}

Go to [Sign In](https://dashboard.tugboat.qa/) and select GitHub.

![Select GitHub sign in](../../_images/github-sign-in.png)

Enter your GitHub Username and Password (or Create an Account), complete Two-Factor Authentication.

![Sign in to GitHub](../../_images/github-sign-in-button.png)

Authorize Tugboat.

![Authorize Tugboat](../../_images/github-authorize-tugboat.png)

Once you complete GitHub authorization, you'll be redirected to the [Create a Tugboat Project](../create-a-new-project/)
screen.

![Create a Tugboat Project](../../_images/create-a-tugboat-project-screen.png)

{{% /expand%}}

### Using the GitHub integration

The GitHub integration gives Tugboat the following features, which you can access in your Project -> Repository
Settings:

- {{% ui-text %}}Build Pull Requests automatically{{% /ui-text %}} On by default; Tugboat automatically creates a
  Preview when a GitHub pull request is opened.
- {{% ui-text %}}Rebuild updated Pull Requests automatically{{% /ui-text %}} On by default; Tugboat automatically
  rebuilds a Preview when the corresponding pull request is updated.
- {{% ui-text %}}Delete Pull Request Previews automatically{{% /ui-text %}} On by default; Tugboat automatically deletes
  a Preview when its pull request is merged or closed.
- {{% ui-text %}}Set Pull Request status{{% /ui-text %}} On by default; Tugboat updates the pull request status to
  reflect the state of its Preview.
- {{% ui-text %}}Set Pull Request deployment status{{% /ui-text %}} Off by default; Tugboat adds a deployment update to
  the pull request when a Preview is built.
- {{% ui-text %}}Post Preview links in Pull Request comments{{% /ui-text %}} Off by default; Tugboat adds a comment to a
  pull request with links to its Preview. The comment author is the person who authenticated the git repo to Tugboat; to
  change this, see:
  [Add a Tugboat Bot to your team](../../administer-tugboat-crew/user-admin/#add-a-tugboat-bot-to-your-team).
- {{% ui-text %}}Build Previews for forked Pull Requests{{% /ui-text %}} Off by default; Tugboat builds Previews for
  pull requests made to the primary repo from forked repositories. **There are security implications from using this
  setting:** any secrets in your Preview will be accessible by the owner of the forked repository. When this feature is
  not enabled, forked pull requests show as available to build (or will attempt to build automatically if you have
  {{% ui-text %}}Build Pull Requests Automatically{{% /ui-text %}} enabled) but the Preview build will fail.

You can also specify the account from which comments are posted to GitHub in this section. For info on customizing this,
see: [Add a Tugboat Bot to your team](../../administer-tugboat-crew/user-admin/#add-a-tugboat-bot-to-your-team).

## GitLab

- [How to connect Tugboat to GitLab](#how-do-i-link-tugboat-to-gitlab)
- [Using the GitLab integration](#using-the-gitlab-integration)

### How do I link Tugboat to GitLab?

1. Go to [Sign In](https://dashboard.tugboat.qa/) and select GitLab.
2. Enter your GitLab Username and Password (or Register).
3. Authorize Tugboat.

Once you complete GitLab authorization, you'll be redirected to the [Create a Tugboat Project](../create-a-new-project/)
screen.

{{%expand "Visual Walkthrough" %}}

Go to [Sign In](https://dashboard.tugboat.qa/) and select GitLab.

![Select GitLab sign in](../../_images/gitlab-sign-in.png)

Enter your GitLab Username and Password (or Register).

![Sign in to GitLab](../../_images/gitlab-sign-in-button.png)

Authorize Tugboat.

![Authorize Tugboat](../../_images/gitlab-authorize-tugboat.png)

Once you complete GitLab authorization, you'll be redirected to the [Create a Tugboat Project](../create-a-new-project/)
screen.

![Create a Tugboat Project](../../_images/create-a-tugboat-project-screen.png)

{{% /expand%}}

### Using the GitLab integration

The GitLab integration gives your Tugboat the following features, which you can access in your Project -> Repository
Settings:

- {{% ui-text %}}Build Merge Requests automatically{{% /ui-text %}} On by default; Tugboat automatically creates a
  Preview when a GitLab merge request is opened.
- {{% ui-text %}}Rebuild updated Merge Requests automatically{{% /ui-text %}} On by default; Tugboat automatically
  creates a Preview when the corresponding merge request is updated.
- {{% ui-text %}}Delete Merge Request Previews automatically{{% /ui-text %}} On by default; Tugboat automatically
  deletes a Preview when its merge request is merged or closed.
- {{% ui-text %}}Set Merge Request build status{{% /ui-text %}} On by default; Tugboat updates the merge request build
  status to reflect the state of its Preview.
- {{% ui-text %}}Post Preview links in Merge Request comments{{% /ui-text %}} Off by default; Tugboat adds a comment to
  a merge request with links to its Preview. The comment author is the person who authenticated the git repo to Tugboat;
  to change this, see:
  [Add a Tugboat Bot to your team](../../administer-tugboat-crew/user-admin/#add-a-tugboat-bot-to-your-team).
- {{% ui-text %}}Build Previews for forked Merge Requests{{% /ui-text %}} Off by default; Tugboat builds Previews for
  merge requests made to the primary repo from forked repositories. **There are security implications from using this
  setting:** any secrets in your Preview will be accessible by the owner of the forked repository. When this feature is
  not enabled, forked merge requests show as available to build (or will attempt to build automatically if you have
  {{% ui-text %}}Build Merge Requests Automatically{{% /ui-text %}} enabled) but the Preview build will fail.

You can also specify the account from which comments are posted to GitLab in this section. For info on customizing this,
see: [Add a Tugboat Bot to your team](../../administer-tugboat-crew/user-admin/#add-a-tugboat-bot-to-your-team).

## Bitbucket

- [How to connect your Tugboat to Bitbucket](#how-do-i-link-tugboat-to-bitbucket)
- [Using the Bitbucket integration](#using-the-bitbucket-integration)

### How do I link Tugboat to Bitbucket?

1. Go to [Sign In](https://dashboard.tugboat.qa/) and select Bitbucket.
2. Enter your Bitbucket Email and Password (or Sign up for an account).
3. Grant Access to Tugboat.

Once you complete Bitbucket authorization, you'll be redirected to the
[Create a Tugboat Project](../create-a-new-project/) screen.

{{%expand "Visual Walkthrough" %}}

Go to [Sign In](https://dashboard.tugboat.qa/) and select Bitbucket.

![Select Bitbucket sign in](../../_images/bitbucket-sign-in.png)

Enter your Bitbucket Email and Password (or Sign up for an account).

![Sign in to Bitbucket](../../_images/bitbucket-sign-in-button.png)

Grant Access to Tugboat.

![Authorize Tugboat](../../_images/bitbucket-authorize-tugboat.png)

Once you complete Bitbucket authorization, you'll be redirected to the
[Create a Tugboat Project](../create-a-new-project/) screen.

![Create a Tugboat Project](../../_images/create-a-tugboat-project-screen.png)

{{% /expand%}}

### Using the Bitbucket integration

The BitBucket integration gives Tugboat the following features, which you can access in your Project -> Repository
Settings:

- {{% ui-text %}}Build Pull Requests automatically{{% /ui-text %}} On by default; Tugboat automatically creates a
  Preview when a Bitbucket pull request is opened.
- {{% ui-text %}}Rebuild updated Pull Requests automatically{{% /ui-text %}} On by default; Tugboat automatically
  rebuilds a Preview when the corresponding pull request is updated.
- {{% ui-text %}}Delete Pull Request Previews automatically{{% /ui-text %}} On by default; Tugboat automatically deletes
  a Preview when its pull request is merged or closed.
- {{% ui-text %}}Set Pull Request status{{% /ui-text %}} On by default; Tugboat updates the pull request status to
  reflect the state of its Preview.
- {{% ui-text %}}Post Preview links in Pull Request comments{{% /ui-text %}} Off by default; Tugboat adds a comment to a
  pull request with links to its Preview. The comment author is the person who authenticated the git repo to Tugboat; to
  change this, see:
  [Add a Tugboat Bot to your team](../../administer-tugboat-crew/user-admin/#add-a-tugboat-bot-to-your-team).
- {{% ui-text %}}Build Previews for forked Pull Requests{{% /ui-text %}} Off by default; Tugboat builds Previews for
  pull requests made to the primary repo from forked repositories. **There are security implications from using this
  setting:** any secrets in your Preview will be accessible by the owner of the forked repository. When this feature is
  not enabled, forked pull requests show as available to build (or will attempt to build automatically if you have
  {{% ui-text %}}Build Pull Requests Automatically{{% /ui-text %}} enabled) but the Preview build will fail.

You can also specify the account from which comments are posted to Bitbucket in this section. For info on customizing
this, see: [Add a Tugboat Bot to your team](../../administer-tugboat-crew/user-admin/#add-a-tugboat-bot-to-your-team).

## Generic Git Server

If you're not using GitHub, GitLab, or Bitbucket, you can use a generic git server with Tugboat. You'll
[sign in to Tugboat](https://dashboard.tugboat.qa/) using an email address, and when you go to add a repo to your
Tugboat project, you can link to a Git URL.

{{% notice warning %}} If your repo isn't connected via Tugboat's GitHub, GitLab, or Bitbucket authentication, you won't
have the integration features to automatically build Previews from Pull Requests, and other related functionality. If
you add GitHub, GitLab, or Bitbucket authentication later, you'll need to delete your generic git server from your
project, and add it again to use it. {{% /notice %}}

## Adding a link to a git provider

Need to add a git provider to your Tugboat account? Whether you created your initial Tugboat account with an email and
now want to add a git provider, or whether you're adding your second or third git provider, here's how to connect your
Tugboat account with additional git providers:

1. Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
   select {{% ui-text %}}Profile{{% /ui-text %}}.
2. Click the {{% ui-text %}}+ Connect Account{{% /ui-text %}} link.
3. Select the git provider whose account you'd like to connect.
4. Follow the instructions to connect to [GitHub](#how-do-i-link-tugboat-to-github),
   [GitLab](#how-do-i-link-tugboat-to-gitlab) or [Bitbucket](#how-do-i-link-tugboat-to-bitbucket).

{{%expand "Visual Walkthrough" %}}

Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
select {{% ui-text %}}Profile{{% /ui-text %}}.

![Go to User drop-down, and select Profile](../../_images/go-to-user-select-profile.png)

Click the {{% ui-text %}}+ Connect Account{{% /ui-text %}} link.

![Click the + Connect Account link](../../_images/add-accounts-connect-account-link.png)

Select the git provider whose account you'd like to connect.

![Select a git provider](../../_images/add-accounts-select-a-git-provider.png)

Follow the instructions to connect to  
 [GitHub](#how-do-i-link-tugboat-to-github), [GitLab](#how-do-i-link-tugboat-to-gitlab) or [Bitbucket](#how-do-i-link-tugboat-to-bitbucket).

{{% /expand%}}

## Disconnect a linked git provider

If you leave an organization or close a git provider account, you may want to disconnect a linked git provider from your
Tugboat account. To do this:

1. Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
   select {{% ui-text %}}Profile{{% /ui-text %}}.
2. Select the git provider whose account you'd like to disconnect.
3. Click the {{% ui-text %}}Disconnect{{% /ui-text %}} link.
4. You'll see a dialog box explaining what happens if you disconnect a linked account; if you want to continue, press
   the {{% ui-text %}}Disconnect{{% /ui-text %}} button.

{{%expand "Visual Walkthrough" %}}

Click the {{% ui-text %}}User{{% /ui-text %}} drop-down in the upper right-hand corner of the Tugboat dashboard, and
select {{% ui-text %}}Profile{{% /ui-text %}}.

![Go to User drop-down, and select Profile](../../_images/go-to-user-select-profile.png)

Select the git provider whose account you'd like to disconnect.

![Tugboat's User Profile pane with a linked Bitbucket account circled](../../_images/select-a-git-provider-to-disconnect.png)

Click the {{% ui-text %}}Disconnect{{% /ui-text %}} link.

![Tugboat's User Profile pane with arrow to Disconnect link next to Bitbucket account](../../_images/click-the-disconnect-link.png)

You'll see a dialog box explaining what happens if you disconnect a linked account; if you want to continue, press the
{{% ui-text %}}Disconnect{{% /ui-text %}} button.

![Dialog box explaining disconnecting a linked git provider account with arrow to "Disconnect" button](../../_images/press-disconnect-button.png)

{{% /expand%}}
