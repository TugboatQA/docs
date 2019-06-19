# Building a Preview

- [Build a Preview](#build-a-preview)
- [Share your Preview](#share-your-preview)
- [Preview Actions]
- [Preview status](#preview-status)
- [Administer Previews](#administer-previews)
- [Set a Base Preview](#set-a-base-preview)
- [Administer Base Previews](#administer-base-previews)
- [Auto-generate Previews](#auto-generate-previews)
- [Auto-delete Previews](#auto-delete-previews)
- [Optimize your Preview builds](#optimize-your-preview-builds)


## Build a Preview

Once you've [set up your Tugboat project](../setting-up-tugboat/create-a-project/index.md), [linked a repo](../setting-up-tugboat/add-repos-to-the-project/index.md), and [put your Config file in the linked repo](../setting-up-tugboat/create-a-config-file/index.md), it's time to build a Preview!

To build a Preview:

Click your username in the upper right-hand corner, and go to Projects;
2) Click the **My Projects** link;
3) Select the project where you want to build a Preview;
4) Click the name of the repo that contains the code you want to use to build the Preview;
5) Scroll down to the **Available to Build** section; by default, you'll see _Branches_, but you can switch to view Tags or Pull Requests that are available to Preview;
6) Press the **Build Preview** button to begin the build.

![Build preview](_images/available_to_build.png)

While the Preview is building, you'll see the Preview appear in the **Latest Previews** section, with a yellow status indicator _building_.

![Preview building](_images/preview_building.png)

When the Preview is ready, the Preview button will turn blue, and you'll see a green status indicator _ready_. Simply press the Preview button to view the Preview. While you're at it, go ahead and [share your Preview](#share-your-preview) - we know you're proud of your work!

![Preview is ready](_images/preview_ready.png)

## Share your Preview

After you've built your Preview, there are a few ways you can share it:

- [Manually share the URL of your Preview](#manually-share-the-url-of-your-preview)
- [Configure Tugboat to automatically post Preview links in pull requests](#configure-tugboat-to-auto-post-preview-links)

### Manually share the URL of your Preview

Want to share a Preview link manually with Lisa in Product, or Al the client? It couldn't be easier. Just go to the Preview you want to share, and either open it and copy the URL from the browser's address bar, or use the browser options to Copy Link on the Preview button.

Send that link to the person who needs to look at the Preview, and they'll be able to view it. That person doesn't need to be a member of your [Tugboat crew](../administering-tugboat-crew/index.md), or able to view the git repo where the code is hosted.

### Configure Tugboat to auto-post Preview links

When you're using the Tugboat integration with [GitHub](../setting-up-tugboat/github/index.md), [GitLab](../setting-up-tugboat/gitlab/index.md) or [BitBucket](../setting-up-tugboat/bitbucket/index.md), you can configure your Tugboat to automatically post links to Previews as comments on pull requests. Configure this option in [Repository Settings](../setting-up-tugboat/modify-settings-for-your-github-gitlab-or-bitbucket-integration/index.md).

## Preview Actions

After you've built a Preview, you'll see an **Actions** drop-down menu just to the left of the Preview button. From here, you can:

- [Clone](#clone)
- [Cancel](#cancel)
- [Delete](#delete)
- [Lock](#lock)
- [Rebuild](#rebuild)
- [Refresh](#refresh)
- [Reset](#reset)
- [Start](#start)
- [Stop](#stop)
- [Unlock](#unlock)

#### Clone

Quickly duplicate a Preview from the snapshot created when the original finished building.

#### Cancel

Cancels the currently running operation.

#### Delete

Delete a Preview.

#### Lock

 Lock a Preview. A locked Preview stays in its current state, and will not be updated by Tugboat, including updates from new pull request commits. This overrides any repo-specific settings for things like _Rebuild Updated Pull Requests Automatically_, _Rebuild Orphaned Previews Automatically_, _Rebuild Stale Previews Automatically_, _Refresh Base Previews Automatically_.

 Lock Previews for longer reviews or to avoid interruptions during a demo.

#### Rebuild

Rebuild an existing Tugboat Preview from scratch.

#### Refresh

1) Pull the latest code from git;
2) Run commands from the `update` section of the [configuration](../setting-up-tugboat/create-a-config-file/index.md);
3) Run commands from the `build` section of the [configuration](../setting-up-tugboat/create-a-config-file/index.md).

#### Reset

Reset a preview to the state it was in when it finished building. This allows you to quickly undo any changes you made for testing, etc.

#### Start

Start a stopped or suspended Tugboat Preview.

#### Stop

Stop a running Tugboat preview. Stopping a preview stops all of its [services](../setting-up-services/index.md), taking it offline.

#### Unlock

Unlock a [locked](#lock) Tugboat Preview.

## Preview status

Preview status is indicated in a couple of different ways:

- [Color](#color)
- [Status message](#status-message)

### Color

- **Green:** Preview has built successfully and is ready to view.
- **Yellow:** A [Preview action](#preview-actions) is in progress.
- **Red:** Preview build has failed, or has been stopped.

### Status message

- **Ready (and active):** When your Preview finishes building successfully, you'll see a green `ready` status, with a green dot to indicate that the Preview is active and ready to view. When you click the link, you'll go directly to your site Preview.
- **Ready (and inactive):** After your Preview has built and some time has passed, you'll see a green `ready` status, with a green half-moon to indicate that the Preview is available, but is currently suspended. When you go to the Preview link, you'll see a splash page while the Preview starts running again, and then you'll be taken to your Preview. If you don't want to wait through the splash page, you can go to the **Actions** drop-down next to the Preview button, and select **Start**; this will restart the Preview. When the half-moon switches to a green dot, you'll be able to go directly to the Preview, bypassing the splash screen.
- **Building:** While your Preview build is in-progress, you'll see a `building` status in yellow. If your Preview build is taking significantly longer than your average build time, displayed in the Repository Stats section lower on the Project -> Repo page, you may want to start [troubleshooting](../troubleshooting/index.md).
- **Rebuilding:** When a rebuild has been kicked off, you'll see a `rebuilding` status in yellow. This indicates a complete Preview rebuild from the beginning of the build process, so it should take as long as a typical build.
- **Refreshing:** When a refresh has been kicked off, you'll see a `refreshing` status in yellow. This indicates a Preview that is pulling in the latest code from git, and then running any commands in the `update` section, followed by the `build` section of the [Configuration file](../setting-up-services/create-a-config-file/index.md).
- **Resuming:** When you've used the Action -> Start option, you'll see a `resuming` status in yellow while the Preview starts spinning up [services](../setting-up-services/index.md) again.
- **Stopping:** When you've used the Action -> Stop option, you'll see a `stopping` status in yellow while the Preview goes through the process of stopping [services](../setting-up-services/index.md).
- **Stopped:** When you've used the Action -> Stop option, you'll see a `stopped` status in red to indicate that the Preview has successfully stopped [services](../setting-up-services/index.md).
- **Failed:** When a Preview build, rebuild or refresh can't complete, you'll see a `failed` status in red. For help with a `failed` preview, take a look at our [troubleshooting](../setting-up-services/index.md) docs, or go to our [Help and Support](#support) page to join our Slack support channel or email us.

## Set a Base Preview

If you want to speed up your Preview builds, and make subsequent Preview builds smaller files, you can set a Base Preview as a starting point for subsequent Previews.

- [How Base Previews work](#how-base-previews-work)
- [How to set a Base Preview](#how-to-set-a-base-preview)
- [Using multiple Base Previews](#using-multiple-base-previews)
- [Building a Preview from scratch after you've set a Base Preview](#building-a-preview-from-scratch-after-you-ve-set-a-base-preview)

### How Base Previews work

When a regular preview is built, the [configuration file](../setting-up-services/create-a-config-file/index.md) typically instructs Tugboat to pull in databases, image files, or other assets. This process can take a while; the larger the assets, the longer the build.

After your Preview has finished building, Tugboat automatically takes a point-in-time snapshot of its disk image, so it has a point of reference of where it can do things like let you quickly [reset](#reset) a Preview back to its original build state. You can leverage this snapshot to create a Base Preview.

When you mark a Preview as a Base Preview, Tugboat can use this as a starting point for all subsequent newly-created Previews. None of the new Previews need to re-download copies of databases, image files, or other assets. Base Previews can dramatically reduce the amount of time required to generate a working Preview.

In addition to speeding up your Preview builds, Tugboat saves disk space by storing only a binary difference between the Base Preview and Previews built from that Base Preview. A new Preview only uses whatever space it needs that differs from the Base Preview. Often, this means a Base Preview might use 2-3GB of space, and a Preview built from it might only use 100-200MB.

### How to set a Base Preview

To create a Base Preview, you'll need to have a Preview build to serve as your starting point.

![Base Preview Selection](_images/base-preview-before.png)

From there, go to the `Manage Base Previews` link on the Repository Dashboard and select the Preview you want to use as a Base Preview.

![Base Preview Selection](_images/base-preview-select.png)

That preview will be moved to the "Base Preview" section of the Repository Dashboard.

![Base Preview Selection](_images/base-preview-after.png)

That's it! From now on, Previews will build from the snapshot created when the Base Preview was built.

### Keeping Base Previews updated

You'll generally want to keep your Base Preview up to date with your latest codebase, and a fresh copy of your database, image files, and other assets. By default, Tugboat automatically checks for updates every night at 12 am ET, and [refreshes](#refresh) your Base Preview with these updates. To change this, check the Repository Settings.

Tugboat performs this update by pulling the latest code from git for the branch or Tag the preview was built from. During the update, Tugboat runs any commands in the `update` and `build` sections of the [configuration](../setting-up-services/create-a-config-file/index.md) file.

### Using multiple Base Previews

Tugboat allows multiple Base Previews to be defined. The effect of doing this is that every preview will generate the corresponding number of Base Preview derivatives. So, if you have three Base Previews defined, and submit a pull request for Tugboat to build a preview, you will end up with three previews for that pull request, each starting from a different Base Preview.

This feature allows you to test code, for instance, against different PHP versions, database content, etc.

### Building a Preview from scratch after you've set a Base Preview

Once you've set a Base Preview, new Previews build on that Base Preview by default. If you want a Preview to build from scratch, instead of a Base Preview:

1) Go to the **Available to Build** section of the Repository Dashboard;
2) Click into the drop-down next to the **Build Preview** button for the Preview you'd like to build from scratch;
3) Select the **Build with no base preview** option.

Now your Preview will build from scratch!

![Build with no base preview](_images/build_with_no_base_preview.png)

## Administer Base Previews

- Add a new Base Preview
- Add multiple Base Previews
- Stop using a Base Preview
- [Keeping Base Previews updated](#keeping-base-previews-updated)
- Using Preview Actions on a Base Preview

### Keeping Base Previews updated

If you want to keep your Base Previews up-to-date, there are two ways you can do it:

- [Automatically update Base Previews](#automatically-update-base-previews)
- [Manually update Base Previews](#manually-update-base-previews)

#### Automatically update Base Previews

You'll generally want to keep your Base Preview up to date with your latest codebase, and a fresh copy of your database, image files, and other assets. By default, Tugboat automatically checks for updates every night at 12 am ET, and [refreshes](#refresh) your Base Preview with these updates. You can go to the Repository Settings to change this.

During this update, Tugboat:
1) Pulls the latest code from git for the branch or Tag the preview was built from;
2) Runs commands in the `update` section of the [configuration](../setting-up-services/create-a-config-file/index.md) file;
3) Runs commands in the `build` section of the [config](../setting-up-services/create-a-config-file/index.md) file.

#### Manually update Base Previews

You can also update a Base Preview manually.

From the Repository Dashboard, click into the **Actions** drop-down next to the Preview button for the Base Preview you want to update. From there, you can Refresh the Base Preview, as well as

## Auto-generate Previews

## Auto-delete Previews



## Optimize your Preview builds
