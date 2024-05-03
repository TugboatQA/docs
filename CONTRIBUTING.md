# Contributing to Tugboat Docs

Welcome! We're glad you're interested in contributing to Tugboat's documentation.

## Setup and Installation

To get started, you'll need to set up Hugo to preview your changes locally:

1. **Install Hugo**: Follow the installation instructions on the [Hugo website]
   (https://gohugo.io/getting-started/installing/).

2. **Install Yarn 1.x**: You'll need Yarn 1.x to run scripts and the local server.
   Install Yarn 1.x from the [classic Yarn documentation]
   (https://classic.yarnpkg.com/en/docs/install#mac-stable).

3. **Running the Local Environment**: Once Hugo and Yarn are installed, you can
   start the local environment by running `hugo serve` or `yarn serve`.

Visit `http://localhost:1313` in your browser to see the site.

## Making Changes

Feel free to make updates from fixing typos to adding new content. Before submitting
your changes, please run the linting script to ensure your updates adhere to our style
guidelines:

    yarn lint

or, to automatically fix issues,

    yarn lint-fix

### Specific Instructions for the Environment Variables Page

The [Environment Variables](https://docs.tugboaatqa.com/reference/environment-variables/)
page is unique because it is generated from a script. Here’s how to update it:

1. Uncomment the `aliases` section in `.tugboat/config.yml`.
2. Modify the `.tugboat/env-vars.yml` file as needed.
3. Push to GitHub and create a pull request.
4. Have Tugboat build the preview with a base preview.
5. Go to `https://[preview-subdomain].tugboatqa.com/vars.md` and copy the markdown.
6. Paste it into `/content/reference/environment-variables.md`.
7. Comment out the `aliases` section in `.tugboat/config.yml`.
8. Commit and push your changes.

Thank you for contributing to our docs site! Your efforts help us keep our
resources helpful and up-to-date.