---
title: "Common Questions"
date: 2019-09-19T12:54:42-04:00
weight: 2
---

## Do you provide production-level hosting?

No. Tugboat previews are intended to be short-lived, and do not come with the stability or support guarantees needed to
host a production application.

## Can I have SSH access to a Preview?

No. Direct SSH access to a Preview is not possible. However, shell access is provided in both the web interface and the
[command line tool](/tugboat-cli/).

## How does Tugboat deal with sending email?

Tugboat makes a best effort to capture outbound email. Using the local `sendmail` or the SMTP server at `$TUGBOAT_SMTP`
will result in email being captured by Tugboat. These captured emails are only saved for as long as the Preview that
sent them exists.

Tugboat does not attempt to capture any other outbound SMTP server connections, so if you are concerned with sending
emails to customers from a QA environment, be sure to update your application configuration to use Tugboat's SMTP
server.

For more details, see:
[Inside a Preview -> Captured Mail](/building-a-preview/preview-deep-dive/inside-a-preview/#captured-mail).

## Why don't you have Alpine versions of some Docker images?

We've run into issues with some packages not working on Alpine, because it uses `musl` and not `glibc`. Many developers
don't know how to solve these sorts of issues. We've chosen to default to Ubuntu / Debian for Tugboat instead. While
that can result in larger disk usage, when using a [Base Preview](/building-a-preview/work-with-base-previews), that
additional disk usage becomes negligible.

You can use your own images with Tugboat, and we do offer an empty
[Alpine image](https://hub.docker.com/r/tugboatqa/alpine) as well.
