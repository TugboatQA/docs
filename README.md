## Theme

The [Hugo Learn Theme](https://github.com/matcornic/hugo-theme-learn) is
included in this repo as a git subtree. To update the theme, find the latest tag
at https://github.com/matcornic/hugo-theme-learn/releases and run the following

```sh
export TAG=2.4.0
git subtree pull --prefix themes/hugo-theme-learn https://github.com/matcornic/hugo-theme-learn.git $TAG --squash
```
