# Setting up your Tugboat

- [Connect with your provider](#connect-with-your-provider)
- [Create a new project](#create-a-new-project)
- [Add repos to the project](#add-repos-to-the-project)
- [Select repo settings (optional)](#select-repo-settings-optional)
- [Create a Config file](#create-a-config-file)

## Connect with your provider

- [Generic git server](#generic-git-server)
- [GitHub](#github)
- [GitLab](#gitlab)
- [BitBucket](#bitbucket)

### Generic git server

If you're not using GitHub, GitLab, or BitBucket, you can use a generic git server with Tugboat. You'll [sign in to Tugboat](https://dashboard.tugboat.qa/) using an email address, and when you go to add a repo to your Tugboat project, you can link to a Git URL.

> #### Warning::Be aware
>
> If your repo isn't connected via Tugboat's GitHub, GitLab, or BitBucket authentication, you won't have the integration features to automatically build Previews from Pull Requests, and other related functionality. If you add this connection later, you'll need to delete the generic git repo from your project, and add it again via the provider integration.

### GitHub

- [How to connect your Tugboat to GitHub](#how-do-i-link-my-tugboat-to-github)
- [Using the GitHub integration](#using-the-github-integration)

#### How do I link my Tugboat to GitHub?

1) Go to [Sign In](https://dashboard.tugboat.qa/) and select GitHub
2) Enter your GitHub Username and Password (or Create an Account), complete Two-Factor Authentication

That's it! Your Tugboat account is now linked to GitHub, and you'll now have access to add your repos to your Tugboat project and enjoy all the benefits of GitHub integration.

#### Using the GitHub integration

The GitHub integration gives your Tugboat a ton of cool features, which you can access in your Project -> Repository Settings:

- Build Pull Requests automatically
- Rebuild updated Pull Requests automatically
- Delete Pull Request Previews automatically
- Set Pull Request status
- Set Pull Request deployment status
- Post Preview links in Pull Request comments
- Build Previews for forked Pull Requests

You can also specify the account from which comments are posted to GitHub in this section. For info on customizing this, see: Change user notifications and Add a Tugboat Bot to your team.

### GitLab

- [How to connect your Tugboat to GitLab](#how-do-i-link-my-tugboat-to-gitlab)
- [Using the GitLab integration](#using-the-gitlab-integration)

#### How do I link my Tugboat to GitLab?

1) Go to [Sign In](https://dashboard.tugboat.qa/) and select GitLab
2) Enter your GitLab Username and Password (or Register)
3) Authorize Tugboat

That's it! Your Tugboat account is now linked to GitLab, and you'll now have access to add your repos to your Tugboat project and enjoy all the benefits of GitLab integration.

#### Using the GitLab integration

The GitLab integration gives your Tugboat a ton of cool features, which you can access in your Project -> Repository Settings:

- Build Merge Requests automatically
- Rebuild updated Merge Requests automatically
- Delete Merge Request Previews automatically
- Set Merge Request build status
- Post Preview links in Merge Request comments
- Build Previews for forked Merge Requests

You can also specify the account from which comments are posted to GitLab in this section. For info on customizing this, see: Change user notifications and Add a Tugboat Bot to your team.

### BitBucket

- [How to connect your Tugboat to BitBucket](#how-do-i-link-my-tugboat-to-bitbucket)
- [Using the BitBucket integration](#using-the-bitbucket-integration)

#### How do I link my Tugboat to BitBucket?

1) Go to [Sign In](https://dashboard.tugboat.qa/) and select BitBucket
2) Enter your BitBucket Email and Password (or Sign up for an account)
3) Grant Access to Tugboat

That's it! Your Tugboat account is now linked to BitBucket, and you'll now have access to add your repos to your Tugboat project and enjoy all the benefits of BitBucket integration.

#### Using the BitBucket integration

The BitBucket integration gives your Tugboat a ton of cool features, which you can access in your Project -> Repository Settings:

- Build Pull Requests automatically
- Rebuild updated Pull Requests automatically
- Delete Pull Request Previews automatically
- Set Pull Request status
- Post Preview links in Pull Request comments
- Build Previews for forked Pull Requests

You can also specify the account from which comments are posted to BitBucket in this section. For info on customizing this, see: Change user notifications and Add a Tugboat Bot to your team.

## Create a new project

Once you've connected Tugboat to your preferred source control provider, it's time to create a new project!

- [How to create a project](#how-to-create-a-project)
- [Things to know about Tugboat projects](#things-to-know-about-tugboat-projects)
- [Add repos to the project](#add-repos-to-the-project)

Then hit the Create Project button, and it's anchors away!

### How to create a project

The first time you sign into Tugboat, you'll go directly to the Create New Project screen.

After you've already got projects, you can add new ones by going to the Tugboat Dashboard and selecting Create New Project.

### Things to know about Tugboat projects

When you're creating a project, there are a few things to keep in mind:

- A Tugboat project is a collection of any number of repos
- Tugboat's performance tiers and billing are specified on the project level
- Users are managed on a project basis

With this in mind, you may find yourself sailing on stormy seas if you're building a lot of Previews (or resource-intensive Previews) on a low-level project tier. If that's the case, you might want to consider structuring your projects by putting repos requiring resource-intensive Preview builds in their own projects, while other repos' Preview builds proceed in a different project without performance hits.

Deciding which users need to be able to access which projects can help you figure out how you want to organize, too. For example, let's say you are building a recipe site that consists of a backend Drupal repository and a frontend React repository. If the entire development team should have access to both repositories within Tugboat, you probably should create a single project for both repositories in Tugboat.

On the other hand, let's say you have a simple WordPress blog that is managed by an outside vendor. Also, you have a separate and unrelated NodeJS application that is a "top secret" internal project your company is working on. It may be best to create two separate projects so that you can manage permissions for each of the projects independently.

### Add repos to the project

Once you've decided how you want to structure your project, add the relevant repos to your project.

When you're creating a project, you'll simply select your repository host from the Provider drop-down, and click the radio button next to the repo you want to add.

![Select Provider and repo](_images/github_select_repo.png)

Alternately, if you're using a generic git server, select Git as the provider, and enter your repo name and Git URL.

![Specify generic git server](_images/generic_git_service.png)

If you want to add repos to a project you've already created:

1) Go to username -> My Projects at the upper-right of the Tugboat screen;
2) Select the project where you want to add the repo;
3) Go to Add a Repository.

From there, you'll be back to the familiar 'select a provider and specify a repo' screen.

Go to username -> My Projects at the upper-right of the Tugboat screen;

![My Projects](_images/username_my_projects.png)

Select the project where you want to add the repo;

![Select the project](_images/select_a_project.png)

Go to Add a Repository.

![My Projects](_images/add_a_repo.png)

## Select repo settings (optional)

After you've created a project, you might want to go in and tweak your Tugboat repo settings. When you go into Repository Settings, you can:

- [Modify settings for your GitHub, GitLab, or BitBucket integration](#modify-settings-for-your-github-gitlab-or-bitbucket-integration)
- [Rebuild Orphaned Previews Automatically](#rebuild-orphaned-previews-automatically)
- [Rebuild Stale Previews Automatically](#rebuild-stale-previews-automatically)
- [Refresh Base Previews Automatically](#refresh-base-previews-automatically)
- [Specify Build Timeout](#specify-build-timeout)
- [Modify Environment Variables](#modify-environment-variables)
- [Set up Remote SSH Access](#set-up-remote-ssh-access)
- [Authenticate with a Docker Registry](#authenticate-with-a-docker-registry)
- [Delete the repo](#delete-the-repo)

Don't forget to hit the **Save Configuration** button after you've checked or unchecked boxes to save your changes.

### Modify settings for your GitHub, GitLab or BitBucket Integration

When you're using the Tugboat integration with GitHub, GitLab or BitBucket, you'll see provider-specific settings for each of your Tugboat repos. These settings enable you to do things like automatically create a Preview when a Pull Request or Merge Request is opened, or post a comment to a PR with links to its preview. For a full list of the provider-specific integration options, check out:

- [Using the GitHub integration](#using-the-github-integration)
- [Using the GitLab integration](#using-the-gitlab-integration)
- [Using the BitBucket integration](#using-the-bitbucket-integration)

### Rebuild Orphaned Previews Automatically

When this option is selected, Tugboat automatically rebuilds Previews when the Base Preview they're built from is rebuilt. This option is turned off by default.

### Rebuild Stale Previews Automatically

When this option is selected, Tugboat automatically rebuilds Previews when the Base Preview they're built from is refreshed. This option is turned off by default.

### Refresh Base Previews Automatically

By default, Tugboat refreshes your Base Previews every day at 12am UTC. You can de-select this checkbox to turn off automatic refresh, or you can specify your preferred interval and time for the refresh to occur. Automatically refreshing Base Previews is a great way to ensure your large assets, such as databases, stay up-to-date, saving you time when you build a new Preview from a recently-refreshed Base Preview.

### Specify Build Timeout

By default, Preview builds timeout at 3600 seconds. You can change the Preview build timeout to your preferred interval.

### Modify Environment Variables

Here's where you can enter environment variables, like API keys or passwords, that you wouldn't want to store in your repo. If you're looking for Tugboat's environment variables to add to your Build Scripts or configuration files, check out [Reference -> Environment Variables](reference/environment-variables/index.md).

### Set up Remote SSH Access

SSH commands run from Previews in this repository use the public key in your repo settings. This key is unique to this repository. Put this public key on the remote boxes that your build scripts or applications on Tugboat need to access.

### Authenticate with a Docker Registry

If you want to pull images from Docker registries that require authentication, you can manage your authorization credentials from within the repo settings.

### Delete the repo

If you want to delete a repo from your Tugboat project, you'll go into the Repository Settings for that repo and press the **Delete Repository** button. Deleting a repo from Tugboat does not affect any data in the git provider repo connected to it, nor does it delete the Tugboat project that contains the repo.

![Delete repository](_images/delete_repo.png)

## Create a Config file

The final step in setting up your Tugboat is committing a YAML Config file in the source's git repository. Think of the Config file as the engine that powers your Tugboat; here's where you specify the services you want to run when your Tugboat Preview builds.

The Tugboat Config file should live at: `.tugboat/config.yml` in the branch, tag, commit or pull request that is being built. The only exception is when you're building from a Base Preview; in that case, the config.yml from the Base Preview is used.

Creating the Config file can be a complex process, just like building a Tugboat's engine from parts! To break things down for you, check out these docs:

- [Setting up Services in your Tugboat](setting-up-services/index.md)
- [Service Code Snippet Library](service-code-snippets/index.md) (pre-populated code snippets to help you get started)
- [Using the Tugboat Command Line Tool](using-the-cli/index.md)
- [Config file reference](reference/tugboat-configuration/index.md) (detailing the attributes you can use when building Services)
- [Debugging Config files](troubleshooting/debugging-config-files/index.md)
