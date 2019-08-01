# Administer Previews

- [Build Previews](#build-previews)
- [Change or update Previews](#change-or-update-previews)
- [Delete Previews](#delete-previews)
- [Change Preview states](#change-preview-states)

## Build Previews

You can build a Preview in a few different ways:

- [Manually build a Preview](#manually-build-a-preview)
- [Auto-generate Previews](#auto-generate-a-preview)

You can also duplicate a Preview using the [Clone Preview](#clone-preview) option. This is a great option if you want a few copies of a Preview so QA and Product can both poke a Preview simultaneously, without worrying about what the other person is doing.

### Manually build a Preview

- [Build a Preview from scratch](#build-a-preview-from-scratch)
- [Build a Preview from a Base Preview](#build-a-preview-from-a-base-preview)

### Build a Preview from scratch

To build a Preview:

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the
   upper-right of the Tugboat screen.
2. Select the project where you want to build a Preview.
3. Click the name of the repo that contains the code you want to use to build
   the Preview.
4. Scroll down to the **Available to Build** section; by default, you'll see
   _Pull Requests_, but you can switch to view Branches or Tags that are
   available to Preview.
5. Press the **Build Preview** button to begin the build.

![Build preview](../_images/available_to_build.png)

While the Preview is building, you'll see the Preview appear in the **Latest
Previews** section, with a yellow status indicator _building_.

![Preview building](../_images/preview_building.png)

When the Preview is ready, the Preview button will turn blue, and you'll see a
green status indicator _ready_. Press the Preview button to view the
Preview. While you're at it, go ahead and
[share your Preview](../share-a-preview/index.md) - we know you're proud of your work!

![Preview is ready](../_images/preview_ready.png)

> #### Note:: Preview size
>
> When you look at your new Preview, you'll see the size of the Preview next to
> the branch/tag/PR that the Preview was built from. In the example above, the
> Preview size is 385.49MB.
>
> Because
> [billing for Tugboat projects is](../../tugboat-billing/index.md#how-does-tugboat-pricing-work),
> in part, based on the total size of all the Previews contained within a
> project, Preview size becomes an important factor when building out multiple
> Previews.
>
> Check out our section on
> [Optimizing Preview builds](../optimize-preview-builds/index.md) for tips on
> [reducing Preview size](../optimize-preview-builds/index.md#optimizing-preview-size).

### Build a Preview from a Base Preview

### Auto-generate a Preview

See: [Auto-generate Previews](../automate-previews/index.md#auto-generate-previews)

### Clone Preview



## Change or update Previews

## Delete Previews

## Change Preview States
