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

#### Trust the `tugboatqa/tugboat/tugboat-cli` formula

You may receive a warning about the `tugboatqa/tugboat` tap not being trusted. It is best practice to only trust the
specific formulae, casks, or commands you need. And trust is required for Homebrew to run formulae, casks, and commands
from taps. To trust the `tugboatqa/tugboat/tugboat-cli` formula, run:

```sh
brew trust --formula tugboatqa/tugboat/tugboat-cli
```

Happy brewing!

### Manual install on MacOS

1. Download the CLI from [https://dashboard.tugboatqa.com/downloads](https://dashboard.tugboatqa.com/downloads). Choose
   **MacOS (Apple Silicon)** or **MacOS (Intel)** to match your Mac.
2. Extract the downloaded `tugboat.tar.gz` file to `/usr/local/bin`, creating the folder if it doesn't exist:

```sh
sudo mkdir -p /usr/local/bin
sudo tar -zxf tugboat.tar.gz -C /usr/local/bin/
```

<a id="macos-catalina"></a>

#### Allow the CLI to run on MacOS

The first time you run a CLI command, MacOS may show a dialog telling you that the Tugboat CLI can't be opened. Until
the CLI is notarized by Apple, here's how to work around this issue:

1. Click **Done** to close the dialog. Don't click **Move to Trash**, which deletes the CLI.
2. Open **System Settings**, and go to **Privacy & Security**.
3. Scroll down to the **Security** section, find the message about `tugboat` being blocked, and press **Open Anyway**.
   The message only appears for about an hour after MacOS blocks the CLI.
4. Enter your password if prompted.
5. Run the CLI command again, and press **Open Anyway** in the dialog that appears.

This saves the Tugboat CLI as an exception to your security settings. From here, you should be able to use it as you
normally would.

If you prefer the command line, you can remove the quarantine attribute from the file instead:

```sh
sudo xattr -d com.apple.quarantine /usr/local/bin/tugboat
```

## Linux

1. Download the CLI from [https://dashboard.tugboatqa.com/downloads](https://dashboard.tugboatqa.com/downloads).
2. Extract the downloaded `tugboat.tar.gz` file to `/usr/local/bin`

```sh
sudo tar -zxf tugboat.tar.gz -C /usr/local/bin/
```
