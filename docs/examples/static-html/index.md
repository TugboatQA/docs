# Static HTML

A static HTML website is the easiest type to set up with Tugboat. All we need is
a webhead service like Apache or Nginx, and we need to point Tugboat to the
correct root folder.

## Services

The only service you'll likely need is Apache or Nginx. If you chose "Static
HTML" as the service bundle when setting up your Repository, then Apache will be
included.

To add or change a Service, you can do so in the Repository settings:

![Repository Settings: Services](_images/static-html-services.png)

The service with "webhead" selected will be the service that will be the
endpoint to serve up your application, so make sure to check the right one.

That's all you need for Services!

## Build Script

By default Tugboat will look for a `/docroot` folder in your repository to serve
up the application. If your site does not live in this folder, you can let
provide the correct path via a Makefile. Replace `public_html` with the correct
location.

[import, lang="makefile"](Makefile)

- `tugboat-init`: this Makefile target will be called when the preview is built from scratch.
- `TUGBOAT_ROOT`: this links to the root of the repository it has cloned onto the server.
- `public_html`: replace this with the correct location in your repository. By default Tugboat will look for a docroot folder: `${TUGBOAT_ROOT}/docroot`.
- `/var/www/html`: this is the location on the server Apache actually uses to serve your application, which is why we have to link to it.

If you add these Makefile settings after your preview has been built, make sure
to rebuild it for the changes to apply.

...And that's all there's to it to set up a Static HTML site!
