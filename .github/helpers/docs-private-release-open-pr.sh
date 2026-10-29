#!/bin/bash
#
# Push HEAD to a release/YYYY-MM-DD-<commit> branch on TugboatQA/docs and open
# a pull request from it into main. Run by docs-private--release.yml in
# TugboatQA/docs-private after docs-private-release-check.sh, in the "private"
# checkout. The commits are public as soon as the push completes.
#
# Required environment variables:
#   GH_TOKEN  Token with contents: write, pull-requests: write, and
#             workflows: write on TugboatQA/docs
#   BASE      TugboatQA/docs main commit that docs-private-release-check.sh compared against
#   HEAD      private commit to release

set -euo pipefail

date="$(date -u +%Y-%m-%d)"
branch="release/${date}-${HEAD:0:7}"

git push "https://x-access-token:${GH_TOKEN}@github.com/TugboatQA/docs.git" "${HEAD}:refs/heads/${branch}"

# The commit list is a code block, so GitHub does not turn #123 references into
# links or @name mentions into notifications in this public pull request.
{
  echo "Releases documentation written in TugboatQA/docs-private."
  echo
  echo "Merge with **Create a merge commit**, then delete the \`${branch}\` branch."
  echo
  echo "## Commits"
  echo
  echo '```'
  git log --reverse --format='%h %s' "${BASE}..${HEAD}"
  echo '```'
} >"${RUNNER_TEMP}/body.md"

url="$(gh pr create --repo TugboatQA/docs --base main --head "${branch}" \
  --title "Release ${date}" --body-file "${RUNNER_TEMP}/body.md")"
echo "Opened ${url}" >>"${GITHUB_STEP_SUMMARY}"
