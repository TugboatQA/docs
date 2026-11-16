#!/bin/bash
#
# Push HEAD to the VERSION branch on TugboatQA/docs and open a pull request
# from it into main. Run by docs-private--release.yml in TugboatQA/docs-private
# after docs-private-release-check.sh, in the checkout of the version branch.
# The commits are public as soon as the push completes.
#
# Required environment variables:
#   GH_TOKEN  Token with contents: write, pull-requests: write, and
#             workflows: write on TugboatQA/docs
#   VERSION   Version branch to release, for example v2.26.47
#   BASE      TugboatQA/docs main commit that docs-private-release-check.sh compared against
#   HEAD      Commit on the version branch to release

set -euo pipefail

git push "https://x-access-token:${GH_TOKEN}@github.com/TugboatQA/docs.git" "${HEAD}:refs/heads/${VERSION}"

# A rerun after the pull request was opened pushes nothing new. Report the
# existing pull request instead of failing on a duplicate.
existing="$(gh pr list --repo TugboatQA/docs --head "${VERSION}" --state open --json url --jq '.[0].url // empty')"
if [ -n "${existing}" ]; then
  echo "A pull request for \`${VERSION}\` is already open: ${existing}" >>"${GITHUB_STEP_SUMMARY}"
  exit 0
fi

# The commit list is a code block, so GitHub does not turn #123 references into
# links or @name mentions into notifications in this public pull request.
{
  echo "Releases the documentation for Tugboat ${VERSION}, written in TugboatQA/docs-private."
  echo
  echo "Merge with **Create a merge commit**, then delete the \`${VERSION}\` branch here and in TugboatQA/docs-private."
  echo
  echo "## Commits"
  echo
  echo '```'
  git log --reverse --no-merges --format='%h %s' "${BASE}..${HEAD}"
  echo '```'
} >"${RUNNER_TEMP}/body.md"

url="$(gh pr create --repo TugboatQA/docs --base main --head "${VERSION}" \
  --title "Release ${VERSION}" --body-file "${RUNNER_TEMP}/body.md")"
echo "Opened ${url}" >>"${GITHUB_STEP_SUMMARY}"
