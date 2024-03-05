# Contributing to Tugboat Docs

Ahoy there, matey! Ready to chart a course through the turbulent seas of documentation? Welcome aboard our vessel! Here be the captain's log on how to join our crew and contribute to the treasure trove of knowledge. So hoist the sails, and let's navigate these waters together!

## Setting Sail (Setup and Installation)

Before ye embark on this grand adventure, ye'll need to prepare yer ship and make sure ye have all the necessary supplies:

1. **Fork and Clone the Repository:** Ye'll be wanting to fork this repository into yer own GitHub account. Then, clone yer fork onto yer local machine to get started.

   ```
   git clone https://github.com/YOUR-USERNAME/docs.git
   cd docs
   ```

2. **Install Hugo:** If Hugo isn't yet part of yer arsenal, it's time to batten down the hatches and install it. Follow the [official Hugo installation instructions](https://gohugo.io/getting-started/installing/) to get set up.

3. **Run the Site Locally:** To make sure yer changes don't lead us astray, run Hugo locally:

   ```
   hugo server
   ```

   This will start a local web server. Navigate to `http://localhost:1313` in yer web compass (browser) to see the site.

## Plotting Your Course (Making Changes)

### Standard Updates

We welcome contributions from all corners of the seven seas, from fixing a simple typo to adding a whole new chapter to our lore. Here’s how ye can make yer mark:

1. **Create a New Branch:** Keep the deck tidy by creating a new branch for yer contributions.

   ```
   git checkout -b your-branch-name
   ```

2. **Make Your Changes:** Whether you're updating the maps (docs) or adding new treasures (sections), make your mark. If you're charting new territories, remember to update the compass rose (table of contents).

3. **Test Your Changes:** Use the `hugo server` command to build and serve your changes on the local seas. Ensure that yer changes look shipshape and that there are no marooned links.

4. **Commit Your Changes:** Once you're satisfied with your bounty, commit it to your branch.

   ```
   git add .
   git commit -m "A descriptive message about your swashbuckling changes"
   ```

### Updating the Environment Variables Reference Page
This is a unique page in that the main content is generated from a script.  Follow these instructions to make changes
to the Environment Variables.

1. Uncomment the `aliases` section in `.tugboat/config.yml`
1. Edit the `.tugboat/env-vars.yml` file as needed.
1. Push to GitHub and create a PR.
1. Have Tugboat build the preview with a base preview.
1. Go to `https://[preview-subdomain].tugboatqa.com/vars.md` and copy the markdown.
1. Paste it into the doc at `/content/reference/environment-variables.md`.
1. Comment out the `aliases` section in `.tugboat/config.yml`.
1. Commit and push again.

## Sending a Message in a Bottle (Submitting a Pull Request)

When your changes are ready and stowed away properly, it's time to send them over:

1. **Push Your Branch:** Push your branch to your fork on the high GitHub seas.

   ```
   git push origin your-branch-name
   ```

2. **Create a Pull Request:** Navigate to the original repository on GitHub. Ye should see a prompt to create a pull request from your new branch. Fill out the pull request template, detailing the voyages of your changes.

3. **Review and Collaboration:** Once your message in a bottle is found, the maintainers will review your changes. Be ready to parley and possibly make further adjustments based on their sage advice.

4. **Merge:** Once your contributions are deemed worthy, a maintainer will merge your changes into the main branch, adding them to the grand lore of our docs site.

## Guidelines for Smooth Sailing

- **Use clear and lively commit messages, arr!**
- **Keep the documentation as fresh as the sea breeze when creating or changing features.**
- **Follow the existing style and layout to maintain harmony amongst the crew.**
- **Test your changes thoroughly before signaling for a review, lest ye want to walk the plank!**

Thank ye for considering a contribution to our Hugo docs site! Your efforts help keep our ship afloat and sailing smoothly for all. Welcome to the crew, and may fair winds follow wherever your code may lead you.
