#!/bin/bash
#
# Push HEAD to a release/YYYY-MM-DD branch on TugboatQA/docs and open a pull
# request from it into main. Run by docs-private--release.yml in
# TugboatQA/docs-private after docs-private-release-check.sh. The commits are
# public as soon as the push completes.
#
# Required environment variables:
#   GH_TOKEN  Token with contents: write, pull-requests: write, and
#             workflows: write on TugboatQA/docs
#   BASE      TugboatQA/docs main commit that docs-private-release-check.sh compared against
#   HEAD      private commit to release

set -euo pipefail

date="$(date -u +%Y-%m-%d)"
branch="release/${date}"

git push "https://x-access-token:${GH_TOKEN}@github.com/TugboatQA/docs.git" "${HEAD}:refs/heads/${branch}"

{
  echo "Releases documentation written in TugboatQA/docs-private."
  echo
  echo "Merge with **Create a merge commit**, then delete the \`${branch}\` branch."
  echo
  echo "## Commits"
  echo
  git log --reverse --format='- %s' "${BASE}..${HEAD}"
} >"${RUNNER_TEMP}/body.md"

url="$(gh pr create --repo TugboatQA/docs --base main --head "${branch}" \
  --title "Release ${date}" --body-file "${RUNNER_TEMP}/body.md")"
echo "Opened ${url}" >>"${GITHUB_STEP_SUMMARY}"
