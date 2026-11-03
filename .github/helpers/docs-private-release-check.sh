#!/bin/bash
#
# Compare the "private" branch, checked out in the current directory, with
# TugboatQA/docs main and write the commits and files a release would publish
# to the job summary. Run by docs-private--release.yml in
# TugboatQA/docs-private. Exits non-zero if private does not contain
# TugboatQA/docs main, has nothing to release, has a commit without a verified
# signature, or is not at COMMIT. Warns about commit messages with #123
# references or @name mentions, which link to the wrong items or notify people
# once they are in TugboatQA/docs.
#
# With COMMIT empty, this is a dry run and sets the step output release=false.
# With COMMIT naming the commit private is at, it sets release=true and the
# base and head outputs for docs-private-release-open-pr.sh.
#
# Required environment variables:
#   GH_TOKEN  Token with contents: read on the repository
#   COMMIT    Secure Hash Algorithm (SHA) hash of the private commit to
#             release, full or abbreviated, or empty for a dry run

set -euo pipefail

git fetch --quiet https://github.com/TugboatQA/docs.git main
base="$(git rev-parse FETCH_HEAD)"
head="$(git rev-parse HEAD)"

if ! git merge-base --is-ancestor "${base}" "${head}"; then
  echo "::error::private does not contain TugboatQA/docs main. Wait for the Sync private workflow, or run it by hand."
  exit 1
fi
if [ "$(git rev-list --count --no-merges "${base}..${head}")" -eq 0 ]; then
  echo "::error::private has no commits that TugboatQA/docs main does not already contain."
  exit 1
fi

# TugboatQA/docs main requires signed commits, and one unverified commit blocks
# merging the release.
unverified="$(gh api --paginate "repos/${GITHUB_REPOSITORY}/compare/${base}...${head}" \
  --jq '.commits[] | select(.commit.verification.verified | not) | .sha')"
if [ -n "${unverified}" ]; then
  echo "::error::These commits do not have verified signatures, so the release could not merge: $(echo "${unverified}" | tr '\n' ' ')"
  exit 1
fi

# Merge commits from the Sync private workflow are left out. GitHub writes
# their messages, and they contain no references or mentions.
references="$(git log --reverse --no-merges -E --format='%h %s' \
  --grep='(^|[[:space:](])(#[0-9]+|@[[:alnum:]-]+)' "${base}..${head}")"

{
  echo "## Release candidate"
  echo
  echo "\`private\` is at \`${head}\`."
  echo
  echo "### Commits"
  echo
  # shellcheck disable=SC2016 # The backticks are Markdown, not command substitution.
  git log --reverse --no-merges --format='- `%h` %s' "${base}..${head}"
  echo
  echo "### Files"
  echo
  echo '```'
  git diff --stat "${base}...${head}"
  echo '```'
  echo
  if [ -n "${references}" ]; then
    echo "### Commits with #123 references or @name mentions"
    echo
    echo "In TugboatQA/docs, these link to unrelated pull requests and issues, or notify people. Fixing them means"
    echo "rewriting their messages on \`private\` before the release."
    echo
    echo '```'
    echo "${references}"
    echo '```'
    echo
  fi
} >>"${GITHUB_STEP_SUMMARY}"
if [ -n "${references}" ]; then
  echo "::warning::Some commit messages contain #123 references or @name mentions. See the job summary."
fi

requested="$(printf '%s' "${COMMIT}" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')"
if [ -z "${requested}" ]; then
  echo "Dry run. To release, run this workflow again with **commit** set to \`${head}\`." >>"${GITHUB_STEP_SUMMARY}"
  echo "release=false" >>"${GITHUB_OUTPUT}"
  exit 0
fi
# Only a hash counts as the reviewed commit. A branch name such as "private"
# would match whatever private is at.
# The error prints requested, not COMMIT. requested has no line breaks, so it
# cannot start a workflow command.
if ! [[ "${requested}" =~ ^[0-9a-f]{7,40}$ ]] || ! resolved="$(git rev-parse --verify --quiet "${requested}^{commit}")"; then
  echo "::error::${requested} is not a commit on private. Copy the commit from the dry run's job summary."
  exit 1
fi
if [ "${resolved}" != "${head}" ]; then
  echo "::error::private is at ${head}, not ${resolved}. Run a new dry run and review it."
  exit 1
fi

{
  echo "release=true"
  echo "base=${base}"
  echo "head=${head}"
} >>"${GITHUB_OUTPUT}"
