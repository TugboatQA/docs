---
title: "Install the Cli"
date: 2019-09-19T10:41:37-04:00
weight: 1
---

The Tugboat Command Line Tool is available for Windows, MacOS, and Linux.

- [Windows](#windows)
- [MacOS](#macos)
- [Linux](#linux)

## Windows

There is currently no installer included with the Windows version of the Tugboat Command Line Tool. You'll either need
to execute it from the directory where you downloaded it, or copy it to a directory in the system PATH variable.

To copy the Tugboat CLI into a directory in the system PATH variable:

1. Download the CLI from [https://dashboard.tugboatqa.com/downloads](https://dashboard.tugboatqa.com/downloads).
2. Create a new folder at `C:\Program Files\Tugboat`, and copy the downloaded `tugboat.exe` to that folder.
3. Add `C:\Program Files\Tugboat` to your system PATH variable.

A good article describing how to modify the PATH variable for each version of Windows can be found at
[https://www.computerhope.com/issues/ch000549.htm](https://www.computerhope.com/issues/ch000549.htm)

## MacOS

We recommend [using Homebrew to manage the Tugboat CLI](#homebrew) for MacOS users, but if you don't use brew, you can
[install the CLI manually](#manual-install-on-macos) using the static binary.

### Homebrew

With [Homebrew installed](https://brew.sh/), first enable the Tugboat Homebrew Tap:

```sh
brew tap tugboatqa/tugboat
```

#### Install the Tugboat CLI with Homebrew

Once you're set up to use the Tugboat Homebrew tap, you can install the Tugboat CLI:

```sh
brew install tugboat-cli
```

#### Update the Tugboat CLI with Homebrew

To update the Tugboat CLI to the latest version with Homebrew:

```sh
brew upgrade tugboat-cli
```

Happy brewing!

### Manual install on MacOS

1. Download the CLI from [https://dashboard.tugboatqa.com/downloads](https://dashboard.tugboatqa.com/downloads).
2. Extract the downloaded `tugboat.tar.gz` file to `/usr/local/bin`

```sh
tar -zxf tugboat.tar.gz -C /usr/local/bin/
```

#### MacOS Catalina

With Catalina's enhanced security features, the first time you try to execute a CLI command, you'll get a dialog telling
you that the Tugboat CLI can't be opened. Until we're able to release a signed version of the CLI, here's how to work
around this issue:

1. Go into the Finder, and locate the `tugboat` file.
2. Control-click or right-click the file, and then choose the **OPEN** option from the drop-down menu.
3. Press the **Open** button.

This saves the Tugboat CLI as an exception to your security settings. From here, you should be able to use it as you
normally would.

## Linux

1. Download the CLI from [https://dashboard.tugboatqa.com/downloads](https://dashboard.tugboatqa.com/downloads).
2. Extract the downloaded `tugboat.tar.gz` file to `/usr/local/bin`

```sh
sudo tar -zxf tugboat.tar.gz -C /usr/local/bin/
```
