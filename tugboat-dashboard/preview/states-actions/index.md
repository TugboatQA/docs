# States And Actions

Every preview has a state. These can be stable states (Ready, Stopped, Canceled) or transition states (Building, Resetting, Suspending, etc). Transition states are states that indicate Tugboat is working on the Preview in the background.

Every preview also has actions available. Which actions are available will depend on what state the Preview is currently in.

![State and Actions](_images/preview-actions.jpg)

## States

Stable States:
- **Failed:** Something went wrong during the build. A good first step of action would be to check the logs in  the Preview Dashboard for more info.
- **Ready:** The preview is successfully built and is ready to be viewed. If a preview is ready, but your site doesn't render as it should, it is possible that you still need more configuration done in your [build script](/build-script/index.md). When a preview state is "Ready", it means Tugboat built the environment and services without any issues.
- **Stopped:** The preview cannot be viewed while stopped. Select "Start" from the actions to start up the preview again.
- **Suspended:** Previews get placed in a suspended state after some time of inactivity. The amount of time depends on your subscription and ranges from 15 minutes (Free) to 60 minutes (Premium). Any HTTP request to the preview will automatically start up again. Depending on the size of your build this can take anywhere between a few seconds to a few minutes.
- **Unavailable:** Something went wrong trying to load the preview. Try triggering a reset from the actions.
- **Cancelled:** The preview was cancelled while building. Select "Rebuild" from the actions to build the preview again from scratch.

Transition States:
- **Building:** Tugboat is building the Preview. This means setting up Services, processing the build scripts from the Makefile, etc.
- **Committing:** TODO: ???
- **Deleting:** The Preview is being deleted. The Pull Request/Tag/Branch will then be listed again in the "Available to Build" section below.
- **Refreshing:** The Preview is being refreshed, meaning it called `tugboat-update` in the [Makefile](/build-script/index.md). This is often used to pull in fresh data from an external database like the production server.
- **Resetting:** TODO: ???
- **Starting:** A Preview is "starting" when it is manually started after being stopped, or when it is coming out of a "Suspended" state.
- **Stopping:** A Preview is "Stopping" when it is manually triggered to stop.
- **Suspending:** A Preview is being Suspended. See "Suspended" above.
- **Waiting:** This is a state Services are in when they are waiting to be set up, while a Preview is in the process of being built.

## Actions

- **Cancel:** Cancels the currently running operation.
- **Commit:** TODO: ??? Save any changes made to a running preview. Any other previews that get built with this as its base will use the saved state.
- **Delete:** Delete a Tugboat preview. After a Preview is deleted the Pull Request/Tag/Branch will then be listed again in the "Available to Build" section below.
- **Lock:** Locking a Tugboat preview still allows full access to the live preview, but disables any further actions on it until it is unlocked, including automatic updates from new commits. This is useful for lengthier reviews or to prevent interruptions during a demo.
- **Rebuild:** Rebuild an existing Tugboat preview.
- **Refresh:** Refresh the codebase and external assets of a Tugboat preview. Refreshing a preview pulls the latest code and allows a preview to update any outside resources, such as a database. When a Preview is being refreshed, it calles `tugboat-update` in the [Makefile](/build-script/index.md).
- **Reset:** TODO: ??? Resets a Tugboat preview to its last saved state. Resetting a preview restores it to its last saved state. Usually, this is the state that resulted from the initial build of the preview, unless a commit has been made since then.
- **Start:** Starts a stopped or suspended Tugboat preview. Starting a preview starts all of its services back up, bringing it back online for normal use.
- **Stop:** Stops a running Tugboat preview. Stopping a preview stops all of its services, taking it offline. This is useful for preventing access to a preview that is not being actively reviewed.
- **Unlock:** Unlocks a locked Tugboat preview. Unlocking a preview allows normal operations to resume, including automatic updates from new commits. This may end up destroying any changes made to the preview, or could interrupt someone actively reviewing or giving a demo on this preview.

Locked State:

![Preview Locked](_images/preview-locked.jpg)
