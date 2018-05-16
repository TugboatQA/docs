# FAQ

## What technologies can we use with Tugboat?
Tugboat supports pretty much anything that runs on Linux. Here is a [list of our current containers](https://github.com/Lullabot/tugboat-registry), but if you have a tech stack that needs more, we can add it. Just let us know.

## What kinds of CMSes work with Tugboat?
We've mainly been using Drupal as the CMS of choice, but Tugboat is platform agnostic. As long as your software can be built and run on Linux, Tugboat can handle it.

## Will Tugboat work with Acquia Cloud?
Yes. We've used Tugboat for projects that run on Acquia cloud many times. While Tugboat itself runs on Linode servers, Your production code and database can still live on the Acquia Cloud servers.

## A preview is failing. What can I do?
See [Troubleshooting](/troubleshooting/index.md).

## How does Tugboat deal with email?
Tugboat makes a best effort to capture outbound email. Using the local `sendmail` or the SMTP server at `$TUGBOAT_SMTP` will result in email being captured by Tugboat. These captured emails are only saved for as long as the Preview that sent them exists.

Tugboat does not attempt to capture any other outbound SMTP server connections, so if you are concerned with sending emails to customers from a QA environment, be sure to update your application configuration to use Tugboat's SMTP server.

## Do you provide production level hosting?
No, Tugboat containers are intended to be (relatively) short lived, and don't come with the sort of stability/support guarantees needed to host a production application. It is also against our [Terms of Service](https://tugboat.qa/terms).

## I don't see a Service for X. Do you support it?
We are adding new services all the time, feel free to [contact us](https://tugboat.qa/support) if there's something new you would like to see supported. For more advanced users it is possible to install any service you might require in the same container as your application this would require installing and configuring it yourself however. See [examples](/build-script/example-build-scripts/) in the build script documentation.

## Which Linux distributions does Tugboat support?

Our containers are currently built on Ubuntu (14.04).

## Do you support Windows?

Unfortunately no, at this time we do not support windows.

## Which repository providers do you support?
Currently GitHub, Bitbucket and GitLab are supported. Self hosted git repositories are available as an option for self hosted [Tugboat for Enterprise](https://tugboat.qa/enterprise). Is there a provider you'd like to see added? [Contact us](https://tugboat.qa/support) and we will look into it.

## Do you support self hosted git repositories?
Self hosted git repositories are available as an option for self hosted [Tugboat for Enterprise](https://tugboat.qa/enterprise).

