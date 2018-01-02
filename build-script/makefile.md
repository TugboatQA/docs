# Makefile
Tugboat uses GNU Make at various stages of operation to call deploy scripts in a project. The following targets can be added to a `Makefile` in the root of the project. If the project is already using a Makefile, these targets can be added to it.

* **tugboat-init** - This is called during `tugboat init` after all of the service containers have been built and the git repo has been cloned. This can be used for things like installing additional libraries that don't come built-in to the tugboat containers.

* **tugboat-update** - This is called during `tugboat update` after updating the local git repo. This can be used to downsync any data or other assets from a production/staging source.

* **tugboat-build** - This is called during "tugboat build" after updating the local git repo. This can be used to perform any deployment scripts that might be required.

Deployments *can* be done by using the Makefile natively, but chances are, you probably just want to call out to another script that does the heavy lifting.

The use of a Makefile, or any of the targets listed above is entirely **optional**.  Tugboat will gracefully skip over these steps if the Makefile, or one of the targets does not exist.

## Tips

* Make sure you use tabs. Using spaces will cause errors.
* You can use [Environment Variables](environment_variables.md) in your scripts.
* Check out [some examples](../examples/makefile.md) to get started.
