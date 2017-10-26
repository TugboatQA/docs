# Glossary of Terms

## Image
Refers to a docker image which is the basis for a container.

## Container
Refers to a docker container which is built upon a software image.

## Preview
Refers to the running environment.

## Base Preview
The base preview from which all other previews are built.

## Plugin
Additional functionality can be provided to tugboat through plugins. A list of available plugins can be seen on a project's settings page

## tugboat cli
A command line interface for tugboat.

## tugboat ui
The user interface for tugboat found at https://dashboard.tugboat.qa/

## Makefile target
A makefile is a file that can specifiy scripts which can be run at various stages in the lifecycle of a container. See [Makefile](../automation/makefile.md) for more information.

## States
Every preview that Tugboat builds is in a certain "state". For example, when
a developer pushes up new code, and Tugboat first sees it, the state that a
preview will go into is *Building*. This means that Tugboat is busy
building the new preview. Once it is complete, the preview will go to
*Ready*. In any state, there are typically some actions that a user can
perform. Based on which state the preview is in, the available actions
change. For instance, you cannot *Unlock* a preview that isn't locked, or
hasn't been built yet.

### Absent
The preview does not exist. Every preview starts in this state. A new pull
request that has not yet been built is in this state, for example.

### Unavailable
If a preview should be "ready" but one or more containers are not online, for
whatever reason, the preview is Unavailable.

### Stopped
When a functioning preview is stopped, with its state saved and ready to be
restarted.

### Ready
When Tugboat is done building, and if no errors were found in the build process,
the preview will go to ready.

## Sub-States

### Locked
When a preview is "Locked", it means that tugboat will not automatically update
the preview if new code is pushed, and will disallow anyone else from rebuilding
or deleting the preview. A preview can be locked or unlocked at any time, in any
state (except absent), or even while transitioning between states. If a preview
is locked during a transition between sates, the current transition will finish,
and no further actions can take place until the preview is unlocked again.

### Failed
When an error occurs during an actions, the preview is moved to the "Failed"
sub-state.

## Actions

### Build
Triggers a fresh build of the preview

### Reset
Resets a preview back to its saved state from immediately after its last build

### Stop
Stop the containers for a given preview. Allows for fine-grained control of
available memory/CPU resources

### Start
Start the containers of a stopped preview and bring it back online

### Delete
Deletes a preview along with all of its medata

### Lock
Locks a preview

### Unlock
Unlocks a preview

### Initialize
Initialize the base containers, which are used for the Base Preview

### Commit
Commit the current state of the Base Preview into the base image used to build new
previews

### Update
Update the Base Preview to the latest codebase, and run anything found in the
tugboat-update [Makefile](../automation/makefile.md) target.
