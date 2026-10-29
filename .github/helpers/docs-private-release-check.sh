#!/bin/bash
#
# Compare the checked-out "private" branch with TugboatQA/docs main and write
# the commits and files a release would publish to the job summary. Run by
# docs-private--release.yml in TugboatQA/docs-private. Exits non-zero if
# private does not contain TugboatQA/docs main, has nothing to release, has a
# commit without a verified signature, or is not at COMMIT.
#
# With COMMIT empty, this is a dry run and sets the step output release=false.
# With COMMIT equal to private, it sets release=true and the base and head
# outputs for docs-private-release-open-pr.sh.
#
# Required environment variables:
#   GH_TOKEN  Token with contents: read on the repository
#   COMMIT    Full SHA of the private commit to release, or empty for a dry run

set -euo pipefail

git fetch --quiet https://github.com/TugboatQA/docs.git main
base="$(git rev-parse FETCH_HEAD)"
head="$(git rev-parse HEAD)"

if ! git merge-base --is-ancestor "${base}" "${head}"; then
  echo "::error::private is not rebased onto TugboatQA/docs main. Wait for the Sync private workflow, or run it by hand."
  exit 1
fi
if [ "$(git rev-list --count "${base}..${head}")" -eq 0 ]; then
  echo "::error::private has no commits that TugboatQA/docs main does not already contain."
  exit 1
fi

# TugboatQA/docs main requires signed commits, and one unverified commit blocks
# merging the release.
unverified=""
for sha in $(git rev-list "${base}..${head}"); do
  verified="$(gh api "repos/${GITHUB_REPOSITORY}/commits/${sha}" --jq .commit.verification.verified)"
  if [ "${verified}" != "true" ]; then
    unverified="${unverified} ${sha}"
  fi
done
if [ -n "${unverified}" ]; then
  echo "::error::These commits do not have verified signatures, so the release could not merge:${unverified}"
  exit 1
fi

{
  echo "## Release candidate"
  echo
  echo "\`private\` is at \`${head}\`."
  echo
  echo "### Commits"
  echo
  # shellcheck disable=SC2016 # The backticks are Markdown, not command substitution.
  git log --reverse --format='- `%h` %s' "${base}..${head}"
  echo
  echo "### Files"
  echo
  echo '```'
  git diff --stat "${base}...${head}"
  echo '```'
  echo
} >>"${GITHUB_STEP_SUMMARY}"

if [ -z "${COMMIT}" ]; then
  echo "Dry run. To release, run this workflow again with **commit** set to \`${head}\`." >>"${GITHUB_STEP_SUMMARY}"
  echo "release=false" >>"${GITHUB_OUTPUT}"
  exit 0
fi
if [ "${COMMIT}" != "${head}" ]; then
  echo "::error::private is at ${head}, not ${COMMIT}. Run a new dry run and review it."
  exit 1
fi

{
  echo "release=true"
  echo "base=${base}"
  echo "head=${head}"
} >>"${GITHUB_OUTPUT}"
