This repository is a public copy of the docs at https://docs.tugboat.qa/.

If you find an issue or would like to improve the documentation there, please
open a Pull Request here! :) Just peek inside of /docs in here to find the
file, fork this repo, make your change, and create a PR for it. Or, just [open
an issue](https://github.com/TugboatQA/docs/issues/new) if you're not
comfortable doing any of that.

### Installation

If you would like to view this locally using GitBook, I've gotten it working
with nodejs 8 and the following steps:

```bash
npm install -g gitbook-cli
cd docs
gitbook install
gitbook build
gitbook serve
```

You should then be able to view the GitBook at localhost:4000.
