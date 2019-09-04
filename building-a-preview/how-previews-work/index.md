# How Previews work

- [The Preview build process: explained](#the-build-process-explained)
- [The Build snapshot](#the-build-snapshot)
- [How Base Previews work](#how-base-previews-work)
- [Preview size: explained](#preview-size-explained)
- [Preview status](#preview-status)

### The build process: explained

When you kick off a Preview build, Tugboat grabs the
[config file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file)
from your linked repository. Tugboat follows the instructions to
[set up each Service in your config file](../../setting-up-services/how-to-set-up-services/index.md),
grabbing the specified Docker images and then executing the
[Service Commands](../../setting-up-services/how-to-set-up-services/index.md#leverage-service-commands-optional)
in three phases:

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

In the process of building your Preview, you'll
[specify a default service](../../setting-up-services/how-to-set-up-services/index.md#define-a-default-service),
and that's the service where your git repository is cloned. If you want to clone
it into other services, see:
[cloning git repositories into your Services](../../setting-up-services/how-to-set-up-services/index.md#clone-git-repositories-into-your-services).

By the time the build is complete, Tugboat has configured Services according to
your config file, including pulling the Docker images you want it to use for
each Service, and has pulled in your code to execute your Preview.

#### Why build phases matter

When you're [changing](../administer-previews/index.md#rebuild-previews) or
[updating](../administer-previews/index.md#refresh-previews) your Preview
builds - or
[building new Previews from a Base Preview](../work-with-base-previews/index.md#building-and-rebuilding-previews-when-youre-using-a-base-preview) -
the build process may bypass some of the build phases. For example, when you
Refresh a Preview, the build process pulls in updated code from your repo, but
only executes Service commands from `update` and `build` - bypassing the `init`
commands.

This can get a little complicated, so we've made a handy-dandy flowchart to help
you keep track of where various processes start in each build phase:

![Tugboat Build Phases](../../_images/tugboat-build-phases.png)

## The Build Snapshot

After your Tugboat Build completes, Tugboat commits the entire container, taking
a snapshot of that container, including all of its data and Services, at that
moment in time.

When you do things like:

- [Clone a Preview](../administer-previews/index.md#duplicate-a-preview)
- [Reset a Preview](../administer-previews/index.md#reset)

Tugboat uses that build snapshot as the basis for those actions, enabling you to
quickly duplicate a Preview build or reset a Preview build to the state it was
in the moment the build completed.

### How Base Previews work

When you build a regular Preview, the
[configuration file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file)
typically instructs Tugboat to pull in databases, image files, or other assets.
This process can take a while; the larger the assets, the longer the build.

When you mark a Preview as a Base Preview, Tugboat uses that Preview's
[build snapshot](#the-build-snapshot) as a starting point for every new Preview
build. None of the new Previews need to re-download copies of databases, image
files, or other assets. Base Previews dramatically reduce the amount of time
required to generate a working Preview.

In addition to speeding up your Preview builds, Tugboat saves disk space by
storing only a binary difference between the Base Preview and Previews built
from that Base Preview. A new Preview only uses whatever space it needs that
differs from the Base Preview. Often, this means a Base Preview might use 2-3GB
of space, and a Preview built from it might only use 100-200MB. This is a great
way to keep a Tugboat Project under your
[billing tier's storage limit](../../tugboat-billing/index.md#how-does-tugboat-pricing-work),
even when you're building multiple Previews.

> #### Hint:: Base Previews and Preview Build Stages
>
> When you set a Base Preview, new Previews you build - including Previews that
> are built automatically from pull requests - use the Base Preview as a
> starting point, and build only from the `build` stage. This means that if
> you're making changes that would be processed during `init` or `update`
> stages, or changing a Docker image, you'll need to either
> [rebuild the Base Preview](../work-with-base-previews/index.md#change-a-base-preview),
> or
> [build the Preview from scratch without the Base Preview](../work-with-base-previews/index.md#build-a-preview-with-no-base-preview).
> For more info, see:
> [Building and Rebuilding Previews when you're using a Base Preview](../work-with-base-previews/index.md#building-and-rebuilding-previews-when-youre-using-a-base-preview).

## Preview size: explained

What Tugboat calls "Preview size" is actually the size of the container in which
the Preview lives. When a Preview is done building, Tugboat takes a snapshot of
the container at that moment in time, and that's what you're seeing in your
Tugboat Dashboard.

When you [set up Services](../../setting-up-services/index.md) in your Preview,
Tugboat pulls those
[Service images](../../setting-up-services/how-to-set-up-services/index.md#specify-a-service-image)
into the Preview container. Each of these Service images contributes to the
total size of the Preview when it is fully built.

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

## Preview status

Preview status is indicated in a couple of different ways:

- [Color](#color)
- [Status message](#status-message)
- [Service states](#service-states)

### Color

- **Green:** Preview has built successfully and is ready to view.
- **Yellow:** A Preview action is in progress.
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
  [Configuration file](../../setting-up-tugboat/index.md#create-a-tugboat-config-file).
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
  at our [troubleshooting](../../troubleshooting/index.md) docs, or go to our
  [Help and Support](../../support/index.md) page to join our Slack support
  channel or email us.
- **Unavailable** - When something goes wrong trying to load the Preview, you
  may see an `unavailable` status. This usually indicates an internal Tugboat
  error. [Resetting](../administer-previews/index.md#reset) a Preview often
  fixes this.
- **Canceled** - When you cancel a Preview while it's building, you'll see a
  `canceled` status in red.

### Service states

A Service could be in any of the above states, as well as:

- **Committing** - Tugboat is taking a snapshot of the current state of the
  Service.
- **Waiting** - Tugboat is performing some operation on the Service's repo, and
  the Service is waiting for its turn.
