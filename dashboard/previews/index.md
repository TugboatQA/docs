# Preview

A Tugboat Preview is the core of what Tugboat provides. It is a fully
functional, working website built from the contents of a git repository. It can
represent a git branch, tag, or pull request. Every Preview has a replica of the
services configured for the Tugboat Repository that it belongs to, and is
completely isolated from any other Tugboat Preview.

Every preview also has a unique URL which can be shared with anyone.

## Listing Your Previews

All Previews belong to some [Tugboat Repository](../repositories/index.md) and
can be listed on that Repository's dashboard. New previews can also be built
from the Repository's dashboard.

## Preview Dashboard

The Preview Dashboard is where you can access a Preview's detailed information.

### Services

This section shows the services connected to a Preview and allows a user to
interact with them by opening logs or launching a terminal

![Services](_images/preview-services.png)

### Service Logs

The Service Logs show the logs provided by the given service. For example, an
Apache service's `access` or `error` logs.

![Apache Log](_images/preview-apache-log.png)

### Terminal

The Terminal provides command line access to the given service. It is available
during most build phases, including "failed", and is incredibly useful for
debugging or making minor adjustments to an existing Preview.

![TuSH](_images/TuSH.png)

### Activity Log

The Activity Log keeps track of every operation that has been performed on the
Preview. This includes internal Tugboat operations as well as output from your
[build script](../../build-script/index.md). This log can be filtered based on
different levels of verbosity.

![Activity Log](_images/preview-activity-log.png)

### Screenshots

Every time a Tugboat Preview is created, Tugboat creates a screenshot of its
root URI. A screenshot of ay URI at any screen width can be requested using this
form.

![Preview Screenshot](_images/preview-screenshot.png)

In addition to seeing a screenshot, Tugboat can also generate visual diffs of a
page for Previews that were created from a Base Preview. This tool is incredibly
useful for spotting small changes that would otherwise be difficult to detect.

![Preview Visual Diff](_images/preview-visualdiff.png)

## Preview Actions

* **Clone:** Quickly duplicates a Preview. Any changes made to this Preview will
  not affect any other Previews.

* **Cancel:** Cancels the currently running operation. This also deletes any
  services associated with the Preview. For instance, service logs and access to
  terminals would no longer be available.

* **Delete:** Delete a Tugboat Preview. After a Preview is deleted the Pull
  Request/Tag/Branch will then be listed again in the "Available to Build"
  section below.

* **Lock:** Locking a Tugboat Preview still allows full access to the live
  Preview, but prevents Tugboat from performing any further actions on it until
  it is unlocked, including automatic updates from new commits. This is useful
  for lengthier reviews or to avoid interruptions during a demo.

* **Rebuild:** Rebuild an existing Tugboat Preview from scratch. Rebuild calls
  `tugboat-init` in the [build script](../../build-script/index.md) if there is
  no Base Preview, and `tugboat-build` if there is a Base Preview.

* **Refresh:** Refresh the codebase and external assets of a Tugboat Preview.
  Refreshing a Preview pulls the latest code and allows a Preview to update any
  outside resources, such as a database. When a Preview is being refreshed, it
  calls `tugboat-update` in the [build script](../../build-script/index.md).

* **Reset:** Resets a Tugboat preview to its last saved state. When a Preview
  has finished building, it creates a saved state of it. So if you make changes
  in your Preview, like changing data or files, a reset will restore the preview
  to its last saved state without having to rebuild the entire Preview.

* **Start:** Starts a stopped or suspended Tugboat Preview. Starting a Preview
  starts all of its services back up, bringing it back online for regular use.

* **Stop:** Stops a running Tugboat preview. Stopping a Preview stops all of its
  services, taking it offline. This is useful for preventing access to a Preview
  that is not being actively reviewed.

* **Unlock:** Unlocks a locked Tugboat Preview. Unlocking a Preview allows
  normal operations to resume, including automatic updates from new commits.
  This may end up destroying any changes made to the Preview, or could interrupt
  someone actively reviewing or giving a demo on this Preview.

## Preview States

###Stable States:

* **Failed:** Something went wrong during the build. A good first step of action
  would be to check the logs in the Preview Dashboard for more information.
* **Ready:** The Preview was successfully built and is ready to be viewed. If a
  Preview is ready, but your site doesn't render as it should, it is possible
  that your [build script](../../build-script/index.md) may still need some
  work. When a Preview state is "Ready", it means Tugboat built the environment
  and services, and no errors were returned from any of the steps.
* **Stopped:** The Preview cannot be viewed while stopped. Select "Start" from
  the actions to start up the Preview again.
* **Suspended:** Previews get placed in a suspended state after some time of
  inactivity. The amount of time depends on the Project's subscription. Any HTTP
  request to the Preview will automatically start it up again. How long that
  takes depends on how much time it takes for each of the services for the
  Preview to start.
* **Unavailable:** Something went wrong trying to load the Preview. Try
  triggering a reset from the actions.
* **Canceled:** The Preview was canceled while building. Select "Rebuild" from
  the actions to build the Preview again from scratch.

###Transition States:

* **Building:** Tugboat is building the Preview. This means setting up Services,
  processing the [build script](../../build-script/index.md), etc.

* **Committing:** This is a state that relates to Services. When a Service is
  committing, a snapshot is being created. If you make changes to any of your
  Services (like modifying files or database values) and choose to "reset" your
  Preview later, your Preview will be restored to this snapshot.

* **Deleting:** The Preview is being deleted. The Pull Request/Tag/Branch will
  then be listed again in the "Available to Build" section below.

* **Refreshing:** The Preview is being refreshed. This is usually used with a
  Base Preview. It pulls the latest code from git and is often used to pull in
  fresh data from an external database like the production server.

* **Resetting:** Resetting means that the Preview is being restored to its last
  saved state. Each time a Preview builds, it keeps its state. Any changes you
  made to the Preview since it was built will be reset.

* **Starting:** A Preview is "starting" when it is manually started after being
  stopped, or when it is coming out of a "Suspended" state.

* **Stopping:** A Preview is "Stopping" when it is manually triggered to stop.

* **Suspending:** A Preview is being Suspended. See "Suspended" above.

* **Waiting:** This is a state Services are in when they are waiting to be set
  up, while a Preview is in the process of being built.
