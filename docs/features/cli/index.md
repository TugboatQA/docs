# Command Line Interface

The Tugboat [Command Line Tool](https://dashboard2.tugboat.qa/downloads)
provides local access to your Tugboat account. It allows you to perform all of
the operations available through the web interface. It also provides access to
the more advanced features of Tugboat.

## Access Tokens

The Tugboat [Command Line Tool](https://dashboard2.tugboat.qa/downloads) will
ask for an [Access Token](https://dashboard2.tugboat.qa/access-tokens) the first
time it is run.

## Installation

The easist way to download and install the CLI tool from Linux/Mac is with the
following commands:

```
curl --remote-name https://dashboard2.tugboat.qa/cli/macos/tugboat
chmod +x ./tugboat
mv ./tugboat /usr/local/bin/
```

## Commands

```
$ tugboat --help

  Usage: tugboat [options] [command]

  Commands:

    api <type> <action> [args...]        Execute a Tugboat API call directly
    auth [options] <id> [args...]        Authenticate a Tugboat repository
    cancel <id>                          Cancel a preview that is currently building
    clone <id>                           Clone a Tugboat Preview
    config <repo> [command] [args...]    Configure a Tugboat Repository
    create <type> [name] [args...]       Create a Tugboat resource
    delete|rm <id> [args...]             Delete a Tugboat resource
    find <id>                            Find a Tugboat resource
    grant <id> [args...]                 Grant access to a Tugboat resource
    history <id> [args...]               History of Tugboat resource
    list|ls <id> [args...]               List a Tugboat resource
    log <id> [args...]                   View the log for a Tugboat resource
    ping <id>                            Validate the authentication of a Tugboat repository
    rebuild <id>                         Rebuild a Tugboat Preview
    refresh <id>                         Refresh a Tugboat Preview
    rekey <id>                           Rekey a Tugboat Preview
    reset <id>                           Reset a Tugboat Preview
    revoke <id> [args...]                Revoke access from a Tugboat resource
    screenshot [options] <id> [args...]  Generate a screenshot of a preview
    shell <id> [args...]                 Start a shell session in a Tugboat resource
    start <id>                           Start a Tugboat Preview
    stop <id>                            Stop a Tugboat Preview
    suspend <id>                         Suspend a Tugboat Preview
    update <id> [args...]                Update a Tugboat resource
    help [cmd]                           display help for [cmd]

  Options:

    -h, --help                  output usage information
    -V, --version               output the version number
    -u, --api-url <url>         The URL to the Tugboat API. Default https://api.tugboat.qa
    -t, --api-token <token>     The Access Token to use to access the Tugboat API
    -k, --no-check-certificate  Do not verify the API certificate when using HTTPS
    -q, --quiet                 Do not show any output, just return a status code when done
    -v, --verbose               Provide verbose output. Ignored if --quiet is specified.
    -j, --json                  Display API output as raw JSON. Ignored if --quiet or --verbose are specified.
    -f, --force                 Attempt to force an operation to execute.
    --debug                     Provide debug output. Does not apply if --quiet is enabled.
    --no-color                  Disable color output
```
