## Theme

The [Hugo Learn Theme](https://github.com/matcornic/hugo-theme-learn) is
included in this repo as a git subtree. To update the theme, find the latest tag
at https://github.com/matcornic/hugo-theme-learn/releases and run the following

```sh
export TAG=2.4.0
git subtree pull --prefix themes/hugo-theme-learn https://github.com/matcornic/hugo-theme-learn.git $TAG --squash
```

## Redirects

Redirects for historic URLs are maintained in `static/.htaccess`. These can be
tested using [Smolder](https://github.com/sky-shiny/smolder) config file in
`test/smolder.yaml`. The tests need to be run against a live instance, like a
Tugboat preview.

```sh
cat test/smolder.yaml | docker run -i mcameron/smolder pr125-mcktkhcj8krhxo5oaa7emgv5gcnf5e5l.tugboat.qa
```
