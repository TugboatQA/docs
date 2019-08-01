# How do Previews work?

### The build process: explained

When you kick off a Preview build, the
[Service Commands](../../setting-up-services/index.md#service-commands) in your
[config file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file) are
executed in three phases:

1. `init`
2. `update`
3. `build`

During the `init` phase, you might use commands that set up the basic preview
infrastructure. This might include things like installing required packages or
tools, or overriding default configuration files.

During the `update` phase, you might use commands that import data or other
assets into a service. This might include things like importing a database, or
syncing image files into a service.

During the `build` phase, you might use commands that build or generate the
actual site. This might include things like compiling Sass files, updating 3rd
party libraries, or running database updates that the current code in the
preview depends on.

When using various [Preview Actions](#preview-actions), the build process may
bypass phases:

- [Preview Actions that start at `init`](#preview-actions-that-start-at-init)
- [Preview Actions that start at `update`](#preview-actions-that-start-at-update)
- [Preview Actions that start at `build`](#preview-actions-that-start-at-build)

> #### Hint:: Troubleshooting Tugboat not pulling changes
>
> Have you changed the Docker image in your build, changed the database you're
> pulling during the `update` phase, or added new resources or commands during
> `init`? A common cause for changes not appearing in your Tugboat Preview is
> that the Preview build isn't a brand new build from scratch. For example,
> building a Preview after [setting a Base Preview](#set-a-base-preview) means
> that new Previews start from the `build` phase - so if you're changing the
> database in `update`, or changing the Docker image (which gets pulled before
> `init`), you won't see your changes in the child Preview. Read through which
> Preview actions start at which phase to help you troubleshoot whether you need
> to do a different type of Preview build - i.e.
> [building a Preview from scratch after setting a Base Preview](#building-a-preview-from-scratch-after-youve-set-a-base-preview).

#### Preview Actions that start at init

Three types of Preview builds start from the very beginning of the process, at
the `init` phase:

- [Building a new Preview](#how-to-build-a-preview) from scratch (without a Base
  Preview)
- [Rebuilding](#rebuild) a Preview without a Base Preview
- [Rebuilding](#rebuild) a Base Preview

> #### Note::Rebuilding a Preview from a Base Preview
>
> If you're
> [Rebuilding a Preview that was built from a Base Preview](#preview-actions-that-start-at-build),
> the build starts at the `build` phase - not the `init` phase.

#### Preview Actions that start at update

Two types of Preview builds start from the `update` phase, bypassing `init`:

- [Refreshing](#refresh) a Preview that has no Base Preview
- [Refreshing](#refresh) a Base Preview

#### Preview Actions that start at build

Two types of Preview builds start from the `build` phase, bypassing `init` and
`update`:

- Building a new Preview from a Base Preview
- Rebuilding a Preview that was built from a Base Preview

> #### Hint:: Making changes to child Previews
>
> Because Previews that are built after setting a Base Preview bypass the `init`
> and `update` phases, if you make changes to the child Preview that would take
> effect during these phases (or even before `init`, such as changing a Docker
> image) - you won't see those changes in the Preview. You'd need to either
> [build the Preview from scratch without the Base Preview](#building-a-preview-from-scratch-after-youve-set-a-base-preview),
> or [rebuild the Base Preview](#using-preview-actions-on-a-base-preview) to see
> those changes. There's one exception, though; if you introduce a new Service
> in a child Preview, that Service's `init` and `update` commands will run when
> building the child Preview.

### How Base Previews work

When you build a regular Preview, the
[configuration file](../../setting-up-services/index.md#create-a-tugboat-config-file)
typically instructs Tugboat to pull in databases, image files, or other assets.
This process can take a while; the larger the assets, the longer the build.

After your Preview has finished building, Tugboat automatically takes a
point-in-time snapshot of its disk image, so it has a point of reference of
where it can do things like let you quickly [reset](#reset) a Preview back to
its original build state. You can leverage this snapshot to create a Base
Preview.

When you mark a Preview as a Base Preview, Tugboat can use this as a starting
point for all subsequent newly-created Previews. None of the new Previews need
to re-download copies of databases, image files, or other assets. Base Previews
can dramatically reduce the amount of time required to generate a working
Preview.

In addition to speeding up your Preview builds, Tugboat saves disk space by
storing only a binary difference between the Base Preview and Previews built
from that Base Preview. A new Preview only uses whatever space it needs that
differs from the Base Preview. Often, this means a Base Preview might use 2-3GB
of space, and a Preview built from it might only use 100-200MB.

> #### Hint:: Base Previews and Preview Build Stages
>
> When you set a Base Preview, new Previews you build - including Previews that
> are built automatically from pull requests - use the Base Preview as a
> starting point, and build only from the `build` stage. This means that if
> you're making changes that would be processed during `init` or `update`
> stages, or changing a Docker image, you'll need to either
> [rebuild the Base Preview](#using-preview-actions-on-a-base-preview), or
> [build the Preview from scratch without the Base Preview](#building-a-preview-from-scratch-after-youve-set-a-base-preview).
> For more info, see:
> [the build process: explained](#the-build-process-explained).

## Preview status

Preview status is indicated in a couple of different ways:

- [Color](#color)
- [Status message](#status-message)

### Color

- **Green:** Preview has built successfully and is ready to view.
- **Yellow:** A [Preview action](#preview-actions) is in progress.
- **Red:** Preview build has failed, or has been stopped.

### Status message

- **Ready (and active):** When your Preview finishes building successfully,
  you'll see a green `ready` status, with a green dot to indicate that the
  Preview is active and ready to view. When you click the link, you'll go
  directly to your site Preview.
- **Ready (and inactive):** After your Preview has built and some time has
  passed, you'll see a green `ready` status, with a green half-moon to indicate
  that the Preview is available, but is currently suspended. When you go to the
  Preview link, you'll see a splash page while the Preview starts running again,
  and then you'll be taken to your Preview. If you don't want to wait through
  the splash page, you can go to the **Actions** drop-down next to the Preview
  button, and select **Start**; this will restart the Preview. When the
  half-moon switches to a green dot, you'll be able to go directly to the
  Preview, bypassing the splash screen.
- **Building:** While your Preview build is in-progress, you'll see a `building`
  status in yellow. If your Preview build is taking significantly longer than
  your average build time, displayed in the Repository Stats section lower on
  the Project -> Repo page, you may want to start
  [troubleshooting](../../troubleshooting/index.md).
- **Rebuilding:** When a rebuild has been kicked off, you'll see a `rebuilding`
  status in yellow. This indicates a complete Preview rebuild from the beginning
  of the build process, so it should take as long as a typical build.
- **Refreshing:** When a refresh has been kicked off, you'll see a `refreshing`
  status in yellow. This indicates a Preview that is pulling in the latest code
  from git, and then running any commands in the `update` section, followed by
  the `build` section of the
  [Configuration file](../../setting-up-services/index.md#create-a-tugboat-config-file).
- **Resuming:** When you've used the Action -> Start option, you'll see a
  `resuming` status in yellow while the Preview starts spinning up
  [services](../../setting-up-services/index.md) again.
- **Stopping:** When you've used the Action -> Stop option, you'll see a
  `stopping` status in yellow while the Preview goes through the process of
  stopping [services](../../setting-up-services/index.md).
- **Stopped:** When you've used the Action -> Stop option, you'll see a
  `stopped` status in red to indicate that the Preview has successfully stopped
  [services](../../setting-up-services/index.md).
- **Suspended** - When Previews have been inactive for a period of time, you'll
  see a `suspended` status. Any incoming HTTP request to the preview will
  automatically start it again.
- **Failed:** When something goes wrong during the the last action that was
  taken on the Preview, you'll see a `failed` status in red. Details should be
  available in the Preview's activity logs. Sometimes a failed Preview can be
  recovered by resetting it. For more help with a `failed` preview, take a look
  at our [troubleshooting](../../setting-up-services/index.md) docs, or go to our
  [Help and Support](../../help-and-support/index.md) page to join our Slack
  support channel or email us.
- **Unavailable** - When something goes wrong trying to load the Preview, you
  may see an `unavailable` status. This usually indicates an internal Tugboat
  error. [Resetting](#reset) a Preview often fixes this.
- **Canceled** - When you cancel a Preview while it's building, you'll see a
  `canceled` status in red.

### Service states

A Service could be in any of the above states, as well as:

- **Committing** - Tugboat is taking a snapshot of the current state of the
  Service.
- **Waiting** - Tugboat is performing some operation on the Service's repo, and
  the Service is waiting for its turn.

## Preview size explained

What Tugboat calls "Preview size" is actually the size of the container in which
the Preview lives. When a Preview is done building, Tugboat takes a snapshot of
the container at that moment in time, and that's what you're seeing in your
Tugboat Dashboard.

When you [set up Services](../../setting-up-services/index.md) in your Preview,
Tugboat pulls those
[Service images](../../setting-up-services/index.md#specify-a-service-image) into
the Preview container. Each of these Service images contributes to the total
size of the Preview when it is fully built.

For example, say I'm building a Preview that uses Tugboat's Service images for
`apache`, `mysql` and `redis`; those Service images are 154MB, 226MB, and 147MB
at the time of this writing. That's over 500MB for these Services; by the time
you add a database file, the container's operating system and other assets,
you'll likely be looking at 800MB to 1GB for a Preview that's only pulling in
100KB of code from your linked git repo.

This is why working from a [Base Preview](#how-base-previews-work) is so helpful
in reducing Preview size; all of those assets are contained in the Base Preview.
When you build a new Preview from the Base Preview, the new Preview only
contains what's different in the PR, Branch or Tag you're building. In my
example above, a new Preview built from the Base Preview was only 20KB.
