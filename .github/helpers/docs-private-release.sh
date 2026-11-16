#!/bin/bash
#
# Push the version branch VERSION, checked out in the current directory with
# every branch fetched, to a branch with the same name on TugboatQA/docs and
# open a pull request from it into main. Run by docs-private--release.yml in
# TugboatQA/docs-private. The commits are public as soon as the push completes.
#
# Before pushing, this exits non-zero if the version branch has no commits
# that TugboatQA/docs main lacks, has a commit without a verified signature, or
# contains the unreleased commits of an older version branch. It warns about
# commit messages with #123 references or @name mentions, which link to the
# wrong items or notify people once they are in TugboatQA/docs.
#
# Required environment variables:
#   GH_TOKEN    Token with contents: read on the repository
#   DOCS_TOKEN  Token with contents: write, pull-requests: write, and
#               workflows: write on TugboatQA/docs
#   VERSION     Version branch to release, for example v2.26.47
#   DRY_RUN     "true" to list the commits in the job summary and stop before
#               the push

set -euo pipefail

if ! [[ "${VERSION}" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "::error::The version is not a version branch name such as v2.26.47."
  exit 1
fi

git fetch --quiet https://github.com/TugboatQA/docs.git main
base="$(git rev-parse FETCH_HEAD)"
head="$(git rev-parse HEAD)"

commits="$(git log --reverse --format='%h %s' "${base}..${head}")"
if [ -z "${commits}" ]; then
  echo "::error::${VERSION} has no commits that TugboatQA/docs main does not already contain."
  exit 1
fi

# A version branch is created from the newest version branch that exists, so
# it contains that branch's commits. Releasing it before the older branch is
# merged into TugboatQA/docs main would publish both.
older=""
while IFS= read -r branch; do
  if [ "${branch}" = "${VERSION}" ] || ! [[ "${branch}" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    continue
  fi
  if [ "$(printf '%s\n' "${branch}" "${VERSION}" | sort -V | head -n 1)" != "${branch}" ]; then
    continue
  fi
  if [ "$(git rev-list --count "${base}..origin/${branch}")" -gt 0 ]; then
    older="${older} ${branch}"
  fi
done < <(git for-each-ref --format='%(refname:lstrip=3)' 'refs/remotes/origin/v*')
if [ -n "${older}" ]; then
  echo "::error::These older version branches have commits that TugboatQA/docs main lacks. Release them first, or delete them if they are abandoned:${older}"
  exit 1
fi

# TugboatQA/docs main requires signed commits, and one unverified commit blocks
# merging the release. The comparison starts at the merge base because this
# repository may not have the commit TugboatQA/docs main is at yet.
merge_base="$(git merge-base "${base}" "${head}")"
unverified="$(gh api --paginate "repos/${GITHUB_REPOSITORY}/compare/${merge_base}...${head}" \
  --jq '.commits[] | select(.commit.verification.verified | not) | .sha')"
if [ -n "${unverified}" ]; then
  echo "::error::These commits do not have verified signatures, so the release could not merge: $(echo "${unverified}" | tr '\n' ' ')"
  exit 1
fi

references="$(git log --reverse -E --format='%h %s' \
  --grep='(^|[[:space:](])(#[0-9]+|@[[:alnum:]-]+)' "${base}..${head}")"
if [ -n "${references}" ]; then
  echo "::warning::Some commit messages contain #123 references or @name mentions. See the job summary."
fi

# The commit lists are code blocks, so GitHub does not turn #123 references
# into links or @name mentions into notifications in the public pull request.
{
  echo "## Commits"
  echo
  echo '```'
  echo "${commits}"
  echo '```'
} >"${RUNNER_TEMP}/commits.md"
{
  echo "\`${VERSION}\` is at \`${head}\`."
  echo
  cat "${RUNNER_TEMP}/commits.md"
  if [ -n "${references}" ]; then
    echo
    echo "### Commits with #123 references or @name mentions"
    echo
    echo "In TugboatQA/docs, these link to unrelated pull requests and issues, or notify people."
    echo
    echo '```'
    echo "${references}"
    echo '```'
  fi
  echo
} >>"${GITHUB_STEP_SUMMARY}"

if [ "${DRY_RUN}" = "true" ]; then
  echo "Dry run. Nothing was pushed." >>"${GITHUB_STEP_SUMMARY}"
  exit 0
fi

git push "https://x-access-token:${DOCS_TOKEN}@github.com/TugboatQA/docs.git" "${head}:refs/heads/${VERSION}"
export GH_TOKEN="${DOCS_TOKEN}"

# A rerun after the pull request was opened pushes nothing new. Report the
# existing pull request instead of failing on a duplicate. --head matches by
# branch name only, so pull requests from forks are left out.
existing="$(gh pr list --repo TugboatQA/docs --head "${VERSION}" --state open --json url,isCrossRepository \
  --jq '[.[] | select(.isCrossRepository | not)][0].url // empty')"
if [ -n "${existing}" ]; then
  echo "A pull request for \`${VERSION}\` is already open: ${existing}" >>"${GITHUB_STEP_SUMMARY}"
  exit 0
fi

{
  echo "Releases the documentation for Tugboat ${VERSION}, written in TugboatQA/docs-private."
  echo
  echo "Merge with **Create a merge commit**, then delete the \`${VERSION}\` branch here and in TugboatQA/docs-private."
  echo
  cat "${RUNNER_TEMP}/commits.md"
} >"${RUNNER_TEMP}/body.md"

url="$(gh pr create --repo TugboatQA/docs --base main --head "${VERSION}" \
  --title "Release ${VERSION}" --body-file "${RUNNER_TEMP}/body.md")"
echo "Opened ${url}" >>"${GITHUB_STEP_SUMMARY}"
