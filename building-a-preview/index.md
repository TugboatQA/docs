# Building a Preview

**Administer Previews**

- [Build Previews](administer-previews/index.md#build-previews)
- [Change or Update Previews](administer-previews/index.md#change-or-update-previews)
- [Delete Previews](administer-previews/index.md#delete-previews)
- [Change Preview states](administer-previews/index.md#change-preview-states)

**Work with Base Previews**

- [Set a Base Preview](work-with-base-previews/index.md#how-to-set-a-base-preview)
- [Change or update Base Previews](work-with-base-previews/index.md#change-or-update-base-previews)
- [Use multiple Base Previews](work-with-base-previews/index.md#use-multiple-base-previews)
- [Stop using a Base Preview](work-with-base-previews/index.md#stop-using-a-base-preview)
- [Delete a Base Preview](work-with-base-previews/index.md#delete-a-base-preview)

**Share a Preview**

- [Manually share a Preview](share-a-preview/index.md#manually-share-the-url-of-your-preview)
- [Auto-post Preview links](share-a-preview/index.md#configure-tugboat-to-auto-post-preview-links)

**Automate Previews**

- [Auto-generate Previews](automate-previews/index.md#auto-generate-previews)
- [Auto-delete Previews](automate-previews/index.md#auto-delete-previews)
- [Auto-update Previews](automate-previews/index.md#auto-update-previews)

**Inside a Preview**

- [Preview logs](inside-a-preview/index.md#preview-logs)
- [Services](inside-a-preview/index.md#services)
- [Captured mail](inside-a-preview/index.md#captured-mail)
- [Visual Diffs](inside-a-preview/index.md#visual-diffs)

**How do Previews work?**

- [Preview build process](how-previews-work/index.md#the-build-process-explained)
- [How Base Previews Work](how-previews-work/index.md#how-base-previews-work)
- [Preview states](how-previews-work/index.md#preview-status)
- [Preview size](how-previews-work/index.md#preview-size-explained)

**Optimize Preview builds**

- [Create a Base Preview that does the heavy lifting](optimize-preview-builds/index.md#use-service-commands-to-create-a-base-preview-that-does-the-heavy-lifting)
- [Automatically refresh Base Previews to update large assets](optimize-preview-builds/index.md#use-the-auto-refresh-base-preview-functionality-to-update-large-assets)
- [Optimize Preview size](optimize-preview-builds/index.md#optimizing-preview-size)
- [Contact Tugboat support for help optimizing your config file](optimize-preview-builds/index.md#contact-tugboat-support-for-help-optimizing-your-config-file)
- [Upgrade your project tier to a higher-performance tier](optimize-preview-builds/index.md#upgrade-your-project-tier-to-a-higher-performance-tier)

## Preview Actions

After you've built a Preview, you'll see an **Actions** drop-down menu to the
left of the Preview button. From here, you can:

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

Quickly duplicate a Preview from the snapshot created when the original finished
building. This is a great option if you want to generate multiple Previews from
the same code so multiple folks can QA or tinker simultaneously. You could also
use this feature to create a demo sandbox, or do limited a/b testing.

#### Cancel

Cancels the currently running operation.

#### Delete

Delete a Preview.

#### Lock

Lock a Preview. A locked Preview stays in its current state, and will not be
updated by Tugboat - which means it won't auto-update the Preview from updated
pull requests or [Preview Actions](#preview-actions). This overrides any
repo-specific settings for things like _Rebuild Updated Pull Requests
Automatically_, _Rebuild Orphaned Previews Automatically_, _Rebuild Stale
Previews Automatically_, _Refresh Base Previews Automatically_.

Lock Previews for longer reviews or to avoid interruptions during a demo.

#### Rebuild

Rebuild an existing Tugboat Preview from scratch. This kicks off a new Preview  
build from the beginning of [the build process](#the-build-process-explained),
starting with `init`.

> #### Note::Rebuilding a Preview from a Base Preview
>
> If you're
> [Rebuilding a Preview that was built from a Base Preview](#preview-actions-that-start-at-build),
> the build starts at the `build` phase - not the `init` phase.

#### Refresh

1. Pull the latest code from git;
2. Run commands from the `update` section of the
   [configuration](../setting-up-tugboat/index.md#create-a-tugboat-config-file/);
3. Run commands from the `build` section of the
   [configuration](../setting-up-tugboat/index.md#create-a-tugboat-config-file).

#### Reset

Reset a Preview to the state it was in when it finished building. This allows
you to quickly undo any changes you made for testing, etc.

#### Start

Start a stopped or suspended Tugboat Preview.

#### Stop

Stop a running Tugboat preview. Stopping a preview stops all of its
[services](../setting-up-services/index.md), taking it offline.

#### Unlock

Unlock a [locked](#lock) Tugboat Preview.
