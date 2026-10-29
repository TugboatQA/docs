#!/bin/bash
#
# Rebase the "private" branch, checked out in the current directory, onto
# TugboatQA/docs main, signing every commit the rebase rewrites as tugbot, and
# force-push it. Run by docs-private--sync.yml in TugboatQA/docs-private. If
# the rebase fails, abort it and exit non-zero so someone rebases private by
# hand.
#
# It rebases onto TugboatQA/docs main, which docs-private main mirrors, so a
# commit pushed only to docs-private main never reaches private.
#
# Required environment variables:
#   GH_TOKEN     Token with contents: write and workflows: write on the repository
#   SIGNING_KEY  Private Secure Shell (SSH) key, without a passphrase, that is
#                registered as a signing key on tugbot

set -euo pipefail

key=~/.ssh/signing_key
install -m 700 -d ~/.ssh
printf '%s\n' "${SIGNING_KEY}" >"${key}"
chmod 600 "${key}"
# Fails if the key is malformed or has a passphrase, either of which would
# otherwise stop the rebase at its first signature.
if ! ssh-keygen -y -P '' -f "${key}" >/dev/null 2>&1; then
  echo "::error::DOCS_PRIVATE_SIGNING_KEY is not a private SSH key without a passphrase."
  exit 1
fi
git config user.name tugbot
git config user.email accounts@tugboatqa.com
git config gpg.format ssh
git config user.signingkey "${key}"

git fetch --quiet https://github.com/TugboatQA/docs.git main
old="$(git rev-parse HEAD)"
if ! git rebase --gpg-sign FETCH_HEAD; then
  conflicts="$(git diff --name-only --diff-filter=U)"
  if [ -d "$(git rev-parse --git-path rebase-merge)" ] || [ -d "$(git rev-parse --git-path rebase-apply)" ]; then
    git rebase --abort
  fi

  if [ -n "${conflicts}" ]; then
    {
      echo "## Rebase failed"
      echo
      echo "\`main\` and \`private\` change the same lines in these files:"
      echo
      echo '```'
      echo "${conflicts}"
      echo '```'
      echo
      echo "Rebase \`private\` onto \`main\` by hand, as described in"
      echo "[the docs-private wiki](https://github.com/TugboatQA/docs-private/wiki)."
    } >>"${GITHUB_STEP_SUMMARY}"
    echo "::error::Rebasing private onto main conflicts. Rebase private by hand."
  else
    {
      echo "## Rebase failed"
      echo
      echo "\`git rebase\` failed without a conflict. See the log of the \"Rebase private onto main\" step."
    } >>"${GITHUB_STEP_SUMMARY}"
    echo "::error::git rebase failed without a conflict. See the log above."
  fi
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
