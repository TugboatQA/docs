#!/bin/bash
#
# Rebase the checked-out "private" branch onto origin/main, signing every
# commit the rebase rewrites as tugbot, and force-push it. Run by
# docs-private--sync.yml in TugboatQA/docs-private. If the rebase conflicts,
# abort it and exit non-zero so someone rebases private by hand.
#
# Required environment variables:
#   GH_TOKEN     Token with contents: write and workflows: write on the repository
#   SIGNING_KEY  Private SSH key registered as a signing key on tugbot

set -euo pipefail

# The rebase rewrites this file in the working tree when main changes it. Bash reads
# a script as it runs, so wrap the body in a function that bash reads in full first.
main() {
  install -m 700 -d ~/.ssh
  printf '%s\n' "${SIGNING_KEY}" >~/.ssh/signing_key
  chmod 600 ~/.ssh/signing_key
  git config user.name tugbot
  git config user.email accounts@tugboatqa.com
  git config gpg.format ssh
  git config user.signingkey ~/.ssh/signing_key

  old="$(git rev-parse HEAD)"
  if ! git rebase --gpg-sign origin/main; then
    git rebase --abort
    {
      echo "## Rebase failed"
      echo
      echo "\`main\` and \`private\` change the same lines. Rebase \`private\` onto \`main\` by hand, as"
      echo "described in [the docs-private wiki](https://github.com/TugboatQA/docs-private/wiki)."
    } >>"${GITHUB_STEP_SUMMARY}"
    echo "::error::Rebasing private onto main conflicts. Rebase private by hand."
    exit 1
  fi
  new="$(git rev-parse HEAD)"

  if [ "${old}" = "${new}" ]; then
    echo "\`private\` already contains \`main\`. Nothing to push." >>"${GITHUB_STEP_SUMMARY}"
    exit 0
  fi

  git push --force-with-lease="private:${old}" \
    "https://x-access-token:${GH_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" HEAD:private

  {
    echo "## Rebased private onto main"
    echo
    echo "| | Commit |"
    echo "| --- | --- |"
    echo "| Previous \`private\` | \`${old}\` |"
    echo "| New \`private\` | \`${new}\` |"
    echo
    echo "To rebase a branch that was cut from the previous \`private\`:"
    echo
    echo '```sh'
    echo "git fetch origin"
    echo "git rebase --onto origin/private ${old} <branch>"
    echo '```'
  } >>"${GITHUB_STEP_SUMMARY}"
}

main "$@"
