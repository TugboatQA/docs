# Working with Base Previews
If you want to speed up your Preview builds, and make subsequent Preview builds
smaller files, you can set a Base Preview as a starting point for subsequent
Previews.

- [Set a Base Preview]
- [Change or update Base Previews]
- [Use multiple Base Previews]
- [Stop using a Base Preview]
- [Delete a Base Preview]

Want to learn more about Base Previews under the cover? Check out: [How Base Previews work](../how-previews-work/index.md#how-base-previews-work).

### How to set a Base Preview

To create a Base Preview, you'll first need to have a
[Preview build](#build-a-preview) to serve as your starting point.

1. Go to the **Manage Base Previews** link on the Repository Dashboard.
2. Click the checkbox next to the Preview you want to use as a Base Preview.
3. Press the **OK** button.

That preview will be moved to the **Base Preview** section of the Repository
Dashboard. From now on, Previews will build from the snapshot created when the
Base Preview was built.

1. Go to the **Manage Base Previews** link on the Repository Dashboard.

![Base Preview Selection](_images/base-preview-before.png)

2. Click the checkbox next to the Preview you want to use as a Base Preview.
3. Press the **OK** button.

![Base Preview Selection](_images/base-preview-select.png)

That preview will be moved to the **Base Preview** section of the Repository
Dashboard.

![Base Preview Selection](_images/base-preview-after.png)

From now on, Previews will build from the snapshot created when the Base Preview
was built.

If you're ever wondering which Base Preview was used when generating a Preview,
check under the name of the Preview; you're looking for the "from _Base Preview
Name_":

![View Base Preview for Preview](_images/biew_base_preview_for_preview.png)

### Change or update Base Previews

You'll generally want to keep your Base Preview up to date with your latest
codebase, and a fresh copy of your database, image files, and other assets. By
default, Tugboat automatically checks for updates every night at 12 am ET, and
[refreshes](#refresh) your Base Preview with these updates. To change this,
check the Repository Settings.

Tugboat performs this update by pulling the latest code from git for the branch
or Tag the preview was built from. During the update, Tugboat runs any commands
in the `update` and `build` sections for services in the
[configuration](../setting-up-services/index.md#create-a-tugboat-config-file)
file.

### Using multiple Base Previews

Tugboat allows multiple Base Previews to be defined. The effect of doing this is
that every preview will generate the corresponding number of Base Preview
derivatives. So, if you have three Base Previews defined, and submit a pull
request for Tugboat to build a Preview, you will end up with three Previews for
that pull request, each starting from a different Base Preview.

This feature allows you to test code, for instance, against different PHP
versions, database content, etc.

![Multiple Base Previews generating multiple Preview builds](_images/multiple_base_preview_preview_builds.png)

### Building a Preview from scratch after you've set a Base Preview

Once you've set a Base Preview, new Previews build on that Base Preview by
default. If you want a Preview to build from scratch, instead of from a Base
Preview:

1. Go to the **Available to Build** section of the Repository Dashboard.
2. Click into the drop-down next to the **Build Preview** button for the Preview
   you'd like to build from scratch.
3. Select the **Build with no base preview** option.

Now your Preview will build from scratch!

![Build with no base preview](_images/build_with_no_base_preview.png)

### Add a new Base Preview

Adding a new Base Preview can mean a few different things:

- [Set a Base Preview for the first time](#set-a-base-preview-for-the-first-time)
- [Add additional/multiple Base Previews](#add-additionalmultiple-base-previews)
- [Stop using the current Base Preview and set a new Base Preview](#stop-using-the-current-base-preview-and-set-a-new-base-preview)

#### Set a Base Preview for the first time

Ready to get started with your first Base Preview? Check out:
[How to set a Base Preview](#how-to-set-a-base-preview).

#### Add additional/multiple Base Previews

Want to use more than one Base Preview? Take a look at:
[Add multiple Base Previews](#add-multiple-base-previews).

#### Stop using the current Base Preview and set a new Base Preview

Want to change the Base Preview you're using? First, you'll need to have a
[Preview build](#build-a-preview) ready to set as your new Base Preview. Then:

1. Go to the **Manage Base Previews** link on the Repository Dashboard.
2. Click the checkbox next to the Base Preview you want to stop using to
   deselect it.
3. Click the checkbox next to the Preview you want to set as your new Base
   Preview.
4. Press the **OK** button.

The Preview you've deselected will move out of the Base Previews section of the
dashboard, and the new Base Preview will appear here, instead.

![Deselect and select new Base Preview](_images/deselect_and_select_new_base_preview.png)

### Add multiple Base Previews

Want to use more than one Base Preview? Follow the instructions in
[How to set a Base Preview](#how-to-set-a-base-preview), and check the
checkboxes next to all of the Previews that you want to use as Base Previews.

![Set multiple Base Previews](_images/set_multiple_base_previews.png)

Keep in mind that when you've selected multiple Base Previews, every new Preview
build (including automated builds from pull requests) will create a build from
_each_ Base Preview. In my sample project, I've set two base Previews, and
building a Preview from a new PR automatically created two Previews.

![Multiple Base Previews generating multiple Preview builds](_images/multiple_base_preview_preview_builds.png)

### Stop using a Base Preview

If you want to stop using a Base Preview:

1. Go to the **Manage Base Previews** link on the Repository Dashboard.
2. Click the checkbox next to the Base Preview you want to stop using.
3. Press the **OK** button.

The deselected Preview will disappear from the Base Preview section of the
dashboard, and subsequent Preview builds - including automated builds from git
provider integrations - will no longer start from that Base Preview.

## Delete a Base Preview

### Keeping Base Previews up-to-date

If you want to keep your Base Previews up-to-date, there are two ways you can do
it:

- [Automatically update Base Previews](#automatically-update-base-previews)
- [Manually update Base Previews](#manually-update-base-previews)

#### Automatically update Base Previews

You'll generally want to keep your Base Preview up to date with your latest
codebase, and a fresh copy of your database, image files, and other assets. By
default, Tugboat automatically checks for updates every night at 12 am ET, and
[refreshes](#refresh) your Base Preview with these updates. You can go to the
Repository Settings to change this.

During this update, Tugboat:

1. Pulls the latest code from git for the branch or Tag the preview was built
   from.
2. Runs commands in the `update` section of the
   [configuration](../setting-up-services/index.md#create-a-tugboat-config-file)
   file.
3. Runs commands in the `build` section of the
   [config](../setting-up-services/index.md#create-a-tugboat-config-file) file.

#### Manually update Base Previews

You can also update a Base Preview manually.

From the Repository Dashboard, click into the **Actions** drop-down next to the
Preview button for the Base Preview you want to update. From there, you can
[Refresh](#refresh) the Base Preview to update it, or [Rebuild](#rebuild) if you
want to build it fresh from scratch.

### Using Preview Actions on a Base Preview

You can use all the normal [Preview Actions](#preview-actions) on a Base Preview
like you would on a regular Preview build - but there are a couple of things to
keep in mind:

- If you're using the options to
  [Rebuild Orphaned Previews Automatically](..setting-up-tugboat/index.md#rebuild-orphaned-previews-automatically)
  and/or
  [Rebuild Stale Previews Automatically](..setting-up-tugboat/index.md#rebuild-stale-previews-automatically),
  [Rebuilding](#rebuild) or [Refreshing](#refresh) a Base Preview will also kick
  off processes to Rebuild or Refresh Previews that were generated from the Base
  Preview.
- Even if you've stopped using a Base Preview, but it was previously used to
  generate child Previews, the above settings still apply; when you Rebuild or
  Refresh that former Base Preview, you'll also be kicking off a process to
  Rebuild or Refresh child Previews.

![Confirm a rebuild from a former Base Preview](_images/confirm_rebuild_from_former_base.png)
