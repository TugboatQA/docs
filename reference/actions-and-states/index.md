# Actions and States

## Preview Actions

* **Clone** - Quickly duplicates a preview from the snapshot created when the
  original finished building.

* **Cancel** - Cancels the currently running operation.

* **Delete** - Deletes a Tugboat Preview.

* **Lock** - Locks a preview. A locked preview stays in its current state, and
  will not be updated by Tugboat, including updates from new pull request
  commits. This is useful for longer reviews or to avoid interruptions during a
  demo.

* **Rebuild** - Rebuild an existing Tugboat Preview from scratch.

* **Refresh** - Pulls the latest code from git and runs any commands found in
  the `update` section followed by the `build` section of the
  [configuration](../../configuring-tugboat/index.md).

* **Reset** - Resets a preview to the state it was in when it finished building.
  This allows you to quickly undo any changes that were made for testing, etc.

* **Start** - Starts a stopped or suspended Tugboat Preview.

* **Stop** - Stops a running Tugboat preview. Stopping a preview stops all of
  its services, taking it offline.

* **Unlock** - Unlocks a locked Tugboat Preview.

## Preview States

* **Failed** - Something went wrong during the the last action that was taken on
  the preview. Details should be available in the preview's activity logs.
  Sometimes a failed preview can be recovered by resetting it.

* **Ready** - The preview is ready to be viewed. This state indicates that
  Tugboat executed any commands defined in the
  [configuration](../../configuring-tugboat/index.md) and no errors were
  returned.

* **Stopped** - The preview cannot be viewed while stopped.

* **Suspended** - Previews get placed in a suspended state after some time of
  inactivity. Any incoming HTTP request to the preview will automatically start
  it again.

* **Unavailable** - Something went wrong trying to load the preview. This
  usually indicates an internal Tugboat error. Resetting a preview often fixes
  this.

* **Canceled** - The preview was canceled while building.

## Service States

A service can be in any of the above states, as well as the following

* **Committing** - Tugboat is currently taking a snapshot of the current state
  of the service.

* **Waiting** - Tugboat is performing some operation on the service's repo, and
  the service is waiting for its turn.
