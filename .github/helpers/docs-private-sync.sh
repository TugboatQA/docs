#!/bin/bash
#
# Bring TugboatQA/docs main into the "private" branch of the repository in
# GITHUB_REPOSITORY. Run by docs-private--sync.yml in TugboatQA/docs-private.
#
# If private has no commits that main lacks, which is the case after a release
# merges, this fast-forwards private to main. Otherwise it merges main into
# private with the GitHub merges API. GitHub signs the merge commit, so private
# keeps its signed-commits rule without a signing key here. If the merge
# conflicts, this exits non-zero so someone merges main into private by hand.
#
# It merges the commit that TugboatQA/docs main is at, so a commit pushed only
# to docs-private main never reaches private.
#
# Required environment variables:
#   GH_TOKEN  Token with contents: write and workflows: write on the repository

set -euo pipefail

main="$(gh api repos/TugboatQA/docs/commits/main --jq .sha)"
status="$(gh api "repos/${GITHUB_REPOSITORY}/compare/private...${main}" --jq .status)"

case "${status}" in
  identical | behind)
    echo "\`private\` already contains \`main\` (\`${main}\`). Nothing to do." >>"${GITHUB_STEP_SUMMARY}"
    ;;
  ahead)
    gh api --method PATCH "repos/${GITHUB_REPOSITORY}/git/refs/heads/private" \
      -f sha="${main}" -F force=false --silent
    echo "Fast-forwarded \`private\` to \`main\` (\`${main}\`)." >>"${GITHUB_STEP_SUMMARY}"
    ;;
  diverged)
    if ! response="$(gh api --include --method POST "repos/${GITHUB_REPOSITORY}/merges" \
      -f base=private -f head="${main}" \
      -f commit_message="Merge TugboatQA/docs main into private" 2>&1)"; then
      if head -n 1 <<<"${response}" | grep -q ' 409 '; then
        {
          echo "## Merge failed"
          echo
          echo "\`main\` and \`private\` change the same lines. Merge \`main\` into \`private\` by hand, as described in"
          echo "[the docs-private wiki](https://github.com/TugboatQA/docs-private/wiki)."
        } >>"${GITHUB_STEP_SUMMARY}"
        echo "::error::Merging main into private conflicts. Merge main into private by hand."
      else
        echo "${response}"
        echo "::error::The merges API failed without a conflict. See the response above."
      fi
      exit 1
    fi
    echo "Merged \`main\` (\`${main}\`) into \`private\`." >>"${GITHUB_STEP_SUMMARY}"
    ;;
  *)
    echo "::error::Unexpected comparison status '${status}' between private and ${main}."
    exit 1
    ;;
esac
