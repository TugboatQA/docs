# Custom Environment Variables

Sometimes there are some "secret" values or other data that you want to be made available to a preview, but
you don't want to commit that data to git, and you don't want to host it somewhere that Tugboat can grab it.
This ususally includes things like API keys to 3rd party services, or a secret value used to encrypt session
cookies that needs to be unique to Tugboat, but shared between your previews.

Tugboat provides a convenient way of injecting these values via custom environment variables. These variables
can be found in on a Tugboat Repository's Settings page in the Repository Configuration sectuion on the Services tab.

![Environment Variable Configuration](_images/envvars-config.png)

Just like the other [environment variables](../environment-variables/index.md) that Tugboat provides, the variables entered here are available
to your previews both while they are building as well as while they are running.

## Storing Complex Data

Environment variables are really only good at storing simple string values. But what if you need to store something more complex, like an encoded JSON string, or the contents of some arbitrary file? One way of accomplishing that is to base64 encode the value, and then decode the value in your build script.

```sh
$ cat file | base64
Q2h1Z2dhIENodWdnYSBUdWdib2F0IQo=
```

Store that value into an environment variable, and in your build script extract it to a file that you can use in your preview with something like the following

```sh
echo $VAR | base64 -D > /tmp/file
```