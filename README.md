<img alt="Tugboat Logo" src="logo.png" style="padding: 0; border: none">

# Welcome to Tugboat!

Tugboat is a system that builds a working preview of a website for any branch,
tag, commit, or pull request in a git repository. It can automatically create
these previews for pull requests by integrating with GitHub, GitLab, or
Bitbucket git repositories.

This document aims to provide the information required to use Tugboat. It
includes tutorials, examples, and references for all experience levels.

## Commands
```yarn install```

- Use this to install the dependencies. It will run ```cross-var gitbook install --gitbook=$npm_package_config_gitbook```

```yarn build```

- This command will build the documentation. It runs ```cross-var gitbook build --gitbook=$npm_package_config_gitbook```

```yarn lint```

- Use this command to make the formatting of the documentation consistent. It runs ```prettier --list-different \"**/*.md\"```

```yarn lint-fix```

- This will apply the formatting changes found with '''yarn lint'''. It runs ```prettier --write \"**/*.md\"```

```yarn test```

- Test that all links work as expected. It runs ```blcl -re ./_book```

```yarn serve```

- Run the documnentation server locally. It runs ```cross-var gitbook serve --gitbook=$npm_package_config_gitbook```

## Callouts
We use the [Gitbook Plugin Callouts module](https://github.com/gubler/gitbook-plugin-callouts) to create callouts within the documentation. 

## Contributing

This document is open-source, and is available on
[GitHub](https://github.com/TugboatQA/docs). If you have any suggestions or
other feedback about this document, we are happy to hear it!
[Open a GitHub issue](https://github.com/TugboatQA/docs/issues/new) or email us
at [support@tugboat.qa](mailto:support@tugboat.qa).

## License Information

This document is licensed as
[Creative Commons Attribution-NonCommercial-ShareAlike CC BY-NC-SA](http://creativecommons.org/licenses/by-nc-sa/4.0/legalcode).

Everything not covered above is licensed under the
[MIT license](https://choosealicense.com/licenses/mit/).
