#!/bin/bash
#
# Bring TugboatQA/docs main into every version branch of the repository in
# GITHUB_REPOSITORY. A version branch is named after the TugboatQA/tugboat
# release that its documentation is for, for example v2.26.47. Run by
# docs-private--sync.yml in TugboatQA/docs-private, in a checkout of that
# repository that has every branch fetched.
#
# For each version branch: if the branch has no commits that main lacks, this
# fast-forwards the branch to main. Otherwise it merges main into the branch
# with the GitHub merges API. GitHub signs the merge commit, so version
# branches keep their signed-commits rule without a signing key here. If the
# merge conflicts, this lists the conflicting files in the job summary and
# continues with the next branch. It exits non-zero if any branch failed, so
# someone merges main into that branch by hand.
#
# It merges the commit that TugboatQA/docs main is at, so a commit pushed only
# to docs-private main never reaches a version branch. If the mirror has not
# copied that commit to this repository yet, this warns and exits zero. The
# mirror's push of that commit starts another run.
#
# Required environment variables:
#   GH_TOKEN  Token with contents: write and workflows: write on the repository

set -euo pipefail

main="$(gh api repos/TugboatQA/docs/commits/main --jq .sha)"
refs="$(gh api --paginate "repos/${GITHUB_REPOSITORY}/git/matching-refs/heads/v" \
  --jq '.[].ref | sub("^refs/heads/"; "")')"
# grep exits 1 when no branch matches, which is not a failure.
branches="$(grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' <<<"${refs}" || [ "$?" -eq 1 ])"
branches="$(sort -V <<<"${branches}")"

if [ -z "${branches}" ]; then
  echo "There are no version branches. Nothing to do." >>"${GITHUB_STEP_SUMMARY}"
  exit 0
fi

if ! gh api "repos/${GITHUB_REPOSITORY}/commits/${main}" --silent 2>/dev/null; then
  echo "TugboatQA/docs \`main\` is at \`${main}\`, which the mirror has not copied to this repository yet. Nothing done." >>"${GITHUB_STEP_SUMMARY}"
  echo "::warning::TugboatQA/docs main (${main}) is not in this repository yet. The mirror's push starts another run."
  exit 0
fi

failed=0
while IFS= read -r branch; do
  if ! status="$(gh api "repos/${GITHUB_REPOSITORY}/compare/${branch}...${main}" --jq .status)"; then
    echo "::error::Comparing ${branch} with ${main} failed."
    failed=1
    continue
  fi

  case "${status}" in
    identical | behind)
      echo "- \`${branch}\` already contains \`main\` (\`${main}\`)." >>"${GITHUB_STEP_SUMMARY}"
      ;;
    ahead)
      if ! gh api --method PATCH "repos/${GITHUB_REPOSITORY}/git/refs/heads/${branch}" \
        -f sha="${main}" -F force=false --silent; then
        echo "::error::Fast-forwarding ${branch} to ${main} failed."
        failed=1
        continue
      fi
      echo "- Fast-forwarded \`${branch}\` to \`main\` (\`${main}\`)." >>"${GITHUB_STEP_SUMMARY}"
      ;;
    diverged)
      if response="$(gh api --include --method POST "repos/${GITHUB_REPOSITORY}/merges" \
        -f base="${branch}" -f head="${main}" \
        -f commit_message="Merge TugboatQA/docs main into ${branch}" 2>&1)"; then
        echo "- Merged \`main\` (\`${main}\`) into \`${branch}\`." >>"${GITHUB_STEP_SUMMARY}"
        continue
      fi
      failed=1
      if ! head -n 1 <<<"${response}" | grep -q ' 409 '; then
        echo "${response}"
        echo "::error::Merging main into ${branch} failed without a conflict. See the response above."
        continue
      fi
      # The merges API does not name the conflicting files. git merge-tree
      # merges without changing the checkout. On a conflict, its first line of
      # output is a tree and the rest are the files. If the first line is not
      # a tree, the checkout, which was made before this script started, lacks
      # one of the two commits.
      files=""
      merge_output="$(git merge-tree --write-tree --name-only --no-messages "origin/${branch}" "${main}" 2>&1 || true)"
      if [[ "$(head -n 1 <<<"${merge_output}")" =~ ^[0-9a-f]{40,64}$ ]]; then
        files="$(tail -n +2 <<<"${merge_output}")"
      fi
      {
        echo "- Merging \`main\` (\`${main}\`) into \`${branch}\` conflicts. Merge \`main\` into \`${branch}\` by hand, as"
        echo "  described in [the docs-private wiki](https://github.com/TugboatQA/docs-private/wiki)."
        if [ -n "${files}" ]; then
          echo
          echo "  Conflicting files:"
          echo
          echo '  ```'
          # shellcheck disable=SC2001 # The pattern is a line start, which ${var//} cannot match.
          sed 's/^/  /' <<<"${files}"
          echo '  ```'
        else
          echo
          echo "  The conflicting files could not be listed from this run's checkout."
        fi
      } >>"${GITHUB_STEP_SUMMARY}"
      echo "::error::Merging main into ${branch} conflicts. Merge main into ${branch} by hand."
      ;;
    *)
      echo "::error::Unexpected comparison status '${status}' between ${branch} and ${main}."
      failed=1
      ;;
  esac
done <<<"${branches}"

exit "${failed}"
