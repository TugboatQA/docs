# FAQ

## What technologies are under the hood?

- **Docker:** This is the container management tool that underlies the whole project. Each environment is run on containers which can be managed by Docker.

- **NodeJS:** The main Tugboat back-end application is written in NodeJS and interacts with the Docker API to help control and manage the various containers.

- **ReactJS:** This (along with NodeJS and socket.io) is what the Tugboat UI is built upon.

## What technologies can we use with Tugboat?
Tugboat supports pretty much anything that runs on linux. Here is a list of our current containers, but if you have a tech stack that needs more, we can add it. Just let us know.
* https://github.com/Lullabot/tugboat-registry

## What kinds of CMSes work on the platform?
We've mainly been using Drupal as the CMS of choice, but Tugboat is platform agnostic. As long as your software can be built and run on linux, Tugboat can handle it.

## Will it work with Acquia Cloud?
Yes. We've used Tugboat for projects that run on Acquia cloud many times. While Tugboat itself runs on Linode servers, your production code and database can still live on the Acquia Cloud servers.

## What is a Makefile target?
See [Makefile](../automation/makefile.md)

## How can I warm the cache of my previews?
You can just add something like this, either to your build script, or as part of the `tugboat-build` [Makefile](../automation/makefile.md) target.
    `curl http://localhost/`

## My environment is failing. What can I do?
See [Troubleshooting](../troubleshooting/index.md).

## How does Tugboat deal with email?
The Docker images from Lullabot's registry are pre-configured to use the host's
MTA using ssmtp. Custom images are encouraged to do the same. The MTA on a Tugboat
host captures all email coming from its Docker containers, and sorts them into
per-environment folders in the tugboat user's inbox. There is also an IMAPs
server running to provide access to these messages.

The credentials for the IMAP connection are stored as tugboat configuration
options named `imap_username` and `imap_password`. When either of these values
change, Tugboat generates a new password file that Dovecot reads for its
authentication. The password is stored in plaintext because it is already
accessible as plaintext through the Tugboat API.

* Host: the server hosting tugboat (example.tugboat.qa)
* Username: the value of the `imap_username` Tugboat configuration.
* Password: the value of the `imap_password` Tugboat configuration.

## Technical QA vs Visual QA

## How do I add my repository?
## How do I add my database?
## What's a Base Preview?
## What's a build script?
## How do I build my first preview?
## Is there a limit to the number of repositories I can have?
## How many users can I invite?
## What can project admins do that invited users can't?
## Can I have SSH access?
## Do you provide production level hosting?
## If master is my Base Preview and I merge a Pull Request into that, will the Base Preview automatically update?
## If master is my Base Preview and new changes get merged into it, will previews that have master as their Base Preview automatically update with those changes?
## I don't see a Service for X. Do you support it?
## What Linux distribution does Tugboat run on? Do you support X?
## Do you support Windows?
## Which repository providers do you support?
## Do you support self hosted git repositories?
## My Preview status says "Ready", but my Preview shows a blank screen. How do I fix this?
## What is the difference between a Project and a Repository?
## How do I know if I should add a Repository to my Project or start a new Project?
