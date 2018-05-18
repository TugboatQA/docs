# Create a Base Preview (optional)

Once you have [created a preview](../create-a-preview/index.md), it can
optionally be promoted to a
"[Base Preview](../../features/base-previews/index.md)". A Base Preview serves
as a starting point for newly built previews. This means that any packages you
installed, databases you imported, or files you downloaded are already available
to the new preview, so those operations do not need to be performed again. This
is a huge time saver.

To promote a preview to a Base Preview, click the `Manage Base Previews` link on
your [Repository Dashboard](../../tugboat-dashboard/repositories/index.md)

![Base Preview Selection](_images/base-preview-before.png)

Then, select the Preview that you want to use as a Base Preview.

![Base Preview Selection](_images/base-preview-select.png)

That preview will moved to the "Base Preview" section of the dashboard

![Base Preview Selection](_images/base-preview-after.png)

Tugboat will now start using this Base Preview as a starting point when building
new previews.

[Read more about Base Previews](../../features/base-previews/index.md)
