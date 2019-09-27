---
title: "Install the Cli"
date: 2019-09-19T10:41:37-04:00
weight: 1
---

The Tugboat Command Line Tool is available for Windows, MacOS, and Linux. In all
three cases, it is a stand-alone binary.

1. Download the CLI from
   [https://dashboard.tugboat.qa/downloads](https://dashboard.tugboat.qa/downloads).
2. Copy it to a location that the operating system can find in its execution
   path.

**Operating Systems**

- [Windows](#windows)
- [MacOS](#macos)
- [Linux](#linux)

### Windows

There is currently no installer included with the Windows version of the Tugboat
Command Line Tool. You'll either need to execute it from the directory where you
downloaded it, or copy it to a directory in the system PATH variable.

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
