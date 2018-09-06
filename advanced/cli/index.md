---
search:
    keywords: ['cli', 'command-line']
---

# Command Line Interface

The Tugboat [Command Line Tool](https://dashboard2.tugboat.qa/downloads)
provides access to your Tugboat account from your local command line. It allows
you to perform all of the operations available through the web interface as well
as other, more advanced features of Tugboat.

## Installation

The Tugboat Command Line Tool is available for Windows, MacOS, and Linux. In all
three cases it is a stand-alone binary and can be downloaded from
[https://dashboard2.tugboat.qa/downloads](https://dashboard2.tugboat.qa/downloads).
Once downloaded, it needs to be copied to a location that the operating system
can find in its execution path.

### Windows

There is currently no installer included with the Windows version of the Tugboat
Command Line Tool. So, it either needs to be executed from the directory it was
downloaded to, or it needs to be copied to a directory in the system PATH
variable.

For the latter, create a new folder at `C:\Program Files\Tugboat`, and copy the
downloaded `tugboat.exe` to that folder. Then, add `C:\Program Files\Tugboat` to
your system PATH variable. A good article describing how to modify the PATH
variable for each version of Windows can be found at
[https://www.computerhope.com/issues/ch000549.htm](https://www.computerhope.com/issues/ch000549.htm)

### MacOS

Extract the downloaded `tugboat.tar.gz` file to `/usr/local/bin`

```sh
tar -zxf tugboat.tar.gz -C /usr/local/bin/
```

### Linux

Extract the downloaded `tugboat.tar.gz` file to `/usr/local/bin`

```sh
sudo tar -zxf tugboat.tar.gz -C /usr/local/bin/
```

## Access Tokens

The Tugboat [Command Line Tool](https://dashboard2.tugboat.qa/downloads) will
ask for an [Access Token](https://dashboard2.tugboat.qa/access-tokens) the first
time it is run.

## Usage

Run `tugboat help` to see a list of commands that can be executed

## Examples

To see a list of your Tugboat Repositories

```sh
tugboat ls repos
```

To see a list of your Tugboat Previews

```sh
tugboat ls previews
```

To build a new Preview from the master branch of a Tugboat Repository with an ID
of `5b02ed093558930001c04cfa`

```sh
tugboat create preview master repo=5b02ed093558930001c04cfa
```

To start a shell on the default service of a preview with an ID of
`5b04c7d14c3dad00016a2e80`

```sh
tugboat shell 5b04c7d14c3dad00016a2e80
```

To view the services of a preview with an ID of `5b04c7d14c3dad00016a2e80`

```sh
tugboat ls services preview=5b04c7d14c3dad00016a2e80
```

To force the deletion of a Preview with an ID of `5b04c7d14c3dad00016a2e80`

```sh
tugboat delete 5b02ed093558930001c04cfa -f
```
