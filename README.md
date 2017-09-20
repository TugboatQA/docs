# Introduction

## Captured Email

* Tugboat attempts to capture outbound email
    * Application must use ports 25 or 587 without TLS
    * Containers can be configured with ssmtp to allow local `sendmail` method

```
root=postmaster
mailhub=mail.tugboat.qa
```

## Makefiles/Scripts

The makefile targets are `tugboat-init`, `tugboat-build`, and `tugboat-update` for backwards compatibility.

`tugboat-init` -- Build a preview from scratch

`tugboat-build` -- Build a preview from a base preview, the assumption being that things like a database and files are already present so not all of the steps from `init` are required

`tugboat-update` -- Refresh a preview. Somewhere between `init` and `build`, in that there is already data, but it needs to be udpated/refreshed

This is a big part of why we want to replace the Makefile with something more flexible. Because of that, we never renamed/augmented the existing targets