# Optimize Preview builds

Do your Previews take a long time to build? Some things, like importing large
assets, are going to take time - but there are some things you can do to speed
up your Preview builds:

- [Use Service Commands to create a Base Preview that does the heavy lifting](#use-service-commands-to-create-a-base-preview-that-does-the-heavy-lifting)
- [Use the Auto Refresh Base Preview functionality to update large assets](#use-the-auto-refresh-base-preview-functionality-to-update-large-assets)
- [Optimize Preview size](#optimizing-preview-size)
- [Contact Tugboat support for help optimizing your Config file](#contact-tugboat-support-for-help-optimizing-your-config-file)
- [Upgrade your project tier to a higher-performance tier](#upgrade-your-project-tier-to-a-higher-performance-tier)

### Use Service Commands to create a Base Preview that does the heavy lifting

The big value of using a Base Preview is that you can front-load the work into a
time-consuming Preview you only have to build once, and then use that as a base
to iterate on with smaller, faster-building Previews.

You can do this by using
[Service Commands](../../setting-up-services/index.md#service-commands) in the
`init` stage of the Preview build to do the resource-intensive, time-intensive
processes - and then
[set that as your Base Preview](../work-with-base-previews/index.md#how-to-set-a-base-preview)
so you don't have to complete those steps in every single build. This is the
perfect time to install a large database that you won't have to update in
subsequent Previews, or download and configure the host of
[services](../../setting-up-services/index.md#services-in-the-context-of-tugboat)
in your Preview.

### Use the Auto Refresh Base Preview functionality to update large assets

If you're updating large assets as part of the `update` stage of your Tugboat
build, you can configure Tugboat to
[automatically refresh your Base Preview](../work-with-base-previews/index.md#automatically-refresh-a-base-preview)
while your crew isn't working. By default, Tugboat automatically refreshes Base
Previews daily at 12am UTC (8pm EDT). You can set this for a time and frequency
that works best for your team, and then you won't have to manually update your
Base Preview when you're about to test an important build - it will already have
the latest database, or any large assets you need, whenever you're ready.

### Optimizing Preview size

If you want to make your Previews smaller, there are a couple of tricks you can
use to reduce Preview size:

- [Use a Base Preview](#work-from-base-previews)
- [Use dummy data](#use-dummy-data)

Looking for more info about Preview size? Check out:
[Preview size explained](../how-previews-work/index.md#preview-size-explained)

#### Work From Base Previews

In addition to speeding up Preview builds, Base Previews can help you
dramatically reduce the size of Previews built from that Base Preview. This is
because the Base Preview contains everything Tugboat needs to run your Preview,
while subsequent Previews only contain the differences between the Base Preview
and the new Preview build.

In practice, this means that a Base Preview might be 3GB in size, but subsequent
Previews might be only 100MB.

Ready to set up a Base Preview? Check out:
[How to set a Base Preview](../work-with-base-previews/index.md#how-to-set-a-base-preview).

#### Use dummy data

Are you pulling in a large production database? You can save Preview space -
_and_ speed up your Preview builds at the same time - by switching to a small
dummy database that contains enough data for testing, but doesn't mirror your
large production behemoth.

### Contact Tugboat support for help optimizing your Config file

Sometimes, speeding up your Preview builds might involve having a second set of
eyes take a look at your Config file and make recommendations to help you
optimize it. This might include something like running a command in `init`
instead of `update`, or scripting a few commands. The team at Tugboat is happy
to help; our [Support](../../support/index.md) page can direct you to our
Tugboat support Slack, or an email address where you can reach us.

### Upgrade your project tier to a higher-performance tier

If it's not a question of optimizing your Config file - for example, if you're
building a complex or resource-intensive sequence of code in every Tugboat
Preview - you might want to consider upgrading your Tugboat Project to a
higher-performance tier. A higher-performance tier gives you more CPU power and
RAM to build your Previews, which can mildly or dramatically speed up your build
times. When build times matter, keep this option in mind.

You can
[change your Tugboat plan in **Project Settings**](../../tugboat-billing/index.md#change-your-tugboat-plan).
