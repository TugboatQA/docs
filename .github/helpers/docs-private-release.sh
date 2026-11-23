#!/bin/bash
#
# Push the version branch VERSION, checked out in the current directory with
# every branch fetched, to a branch with the same name on TugboatQA/docs and
# open a pull request from it into main, then delete the version branch from
# TugboatQA/docs-private. Run by docs-private--release.yml in
# TugboatQA/docs-private. The commits are public as soon as the push completes.
# From then on, changes for that version are made on the pull request. It turns
# on auto-merge with a merge commit for the pull request, so the merge button
# and its choice of merge method are not used.
#
# Before pushing, this exits non-zero if the version branch has no commits
# that TugboatQA/docs main lacks, changes a file under .github/, has a commit
# without a verified signature, contains the unreleased commits of an older
# version branch, or is the base of an open pull request, which deleting the
# branch would close. It warns about
# commit messages with references such as #123 or @name mentions, which link to
# the wrong items or notify people once they are in TugboatQA/docs.
#
# Required environment variables, besides the ones GitHub Actions sets:
#   GH_TOKEN    Token with contents: write and pull-requests: read on
#               TugboatQA/docs-private
#   VERSION     Version branch to release, for example v2.26.47
#   DRY_RUN     "true" to list the commits in the job summary and stop before
#               the push
#   DOCS_TOKEN  Token with contents: write, pull-requests: write, and
#               workflows: write on TugboatQA/docs. Not needed for a dry run.

set -euo pipefail

if ! [[ "${VERSION}" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "::error::The version is not a version branch name such as v2.26.47."
  exit 1
fi

git fetch --quiet https://github.com/TugboatQA/docs.git main
base="$(git rev-parse FETCH_HEAD)"
head="$(git rev-parse HEAD)"

if [ "${head}" != "$(git rev-parse --verify --quiet "refs/remotes/origin/${VERSION}")" ]; then
  echo "::error::The checkout is not at the ${VERSION} branch."
  exit 1
fi

commits="$(git log --reverse --format='%h %s' "${base}..${head}")"
if [ -z "${commits}" ]; then
  echo "::error::${VERSION} has no commits that TugboatQA/docs main does not already contain."
  exit 1
fi

# Files the version branch changes, without the changes main has made since
# the branch was created.
merge_base="$(git merge-base "${base}" "${head}")"
files="$(git diff --stat "${merge_base}" "${head}")"

# The pattern leaves out an @ that follows a letter or digit, which is an email
# address.
references="$(git log --reverse -E --format='%h %s' \
  --grep='#[0-9]+|GH-[0-9]+|(^|[^[:alnum:]])@[[:alnum:]-]+|github\.com/TugboatQA/docs-private' "${base}..${head}")"
if [ -n "${references}" ]; then
  echo "::warning::Some commit messages contain references or @name mentions. See the job summary."
fi

# The commit lists are code blocks, so GitHub does not turn #123 references
# into links or @name mentions into notifications in the public pull request.
{
  echo "## Commits"
  echo
  echo '```'
  echo "${commits}"
  echo '```'
  echo
  echo "## Files"
  echo
  echo '```'
  echo "${files}"
  echo '```'
} >"${RUNNER_TEMP}/commits.md"
{
  echo "\`${VERSION}\` is at \`${head}\`."
  echo
  cat "${RUNNER_TEMP}/commits.md"
  if [ -n "${references}" ]; then
    echo
    echo "### Commits with references or @name mentions"
    echo
    echo "In TugboatQA/docs, these link to unrelated pull requests and issues, or notify people."
    echo
    echo '```'
    echo "${references}"
    echo '```'
  fi
  echo
} >>"${GITHUB_STEP_SUMMARY}"

# Workflows on TugboatQA/docs run on every push and pull request with access
# to that repository's secrets, so a changed workflow file would run as soon as
# this script pushes it, before anyone reviews it there.
github_files="$(git diff --name-only "${merge_base}" "${head}" -- .github/)"
if [ -n "${github_files}" ]; then
  echo "::error::${VERSION} changes files under .github/. Make those changes in a pull request on TugboatQA/docs: $(echo "${github_files}" | tr '\n' ' ')"
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
# merging the release. Every commit to release must be in the list of verified
# commits, so a commit that the API response leaves out counts as unverified.
# The comparison starts at the merge base because this repository may not have
# the commit TugboatQA/docs main is at yet.
verified="$(gh api --paginate "repos/${GITHUB_REPOSITORY}/compare/${merge_base}...${head}" \
  --jq '.commits[] | select(.commit.verification.verified) | .sha')"
unverified="$(git rev-list "${base}..${head}" | grep -vxFf <(echo "${verified}") || [ "$?" -eq 1 ])"
if [ -n "${unverified}" ]; then
  echo "::error::These commits do not have verified signatures, so the release could not merge: $(echo "${unverified}" | tr '\n' ' ')"
  exit 1
fi

# Deleting the version branch closes every open pull request into it.
open="$(gh pr list --repo "${GITHUB_REPOSITORY}" --base "${VERSION}" --state open --json number \
  --jq 'map("#\(.number)") | join(" ")')"
if [ -n "${open}" ]; then
  echo "::error::These pull requests into ${VERSION} are still open. Merge or close them first: ${open}"
  exit 1
fi

if [ "${DRY_RUN}" = "true" ]; then
  echo "Dry run. Nothing was pushed." >>"${GITHUB_STEP_SUMMARY}"
  exit 0
fi

# The push is rejected if the branch on TugboatQA/docs has commits that this
# one lacks. That happens only if the version branch was created again after
# an earlier release of it.
# The token goes in a header, not in the URL, so git cannot print it in an
# error message.
credentials="$(printf 'x-access-token:%s' "${DOCS_TOKEN}" | base64 | tr -d '\n')"
if ! git -c "http.https://github.com/.extraheader=AUTHORIZATION: basic ${credentials}" \
  push https://github.com/TugboatQA/docs.git "${head}:refs/heads/${VERSION}"; then
  echo "::error::The push failed. If ${VERSION} on TugboatQA/docs has commits that this branch lacks, make further changes on the release pull request there."
  exit 1
fi

{
  echo "Releases the documentation for Tugboat ${VERSION}, written in TugboatQA/docs-private."
  echo
  echo "The \`${VERSION}\` branch in TugboatQA/docs-private is deleted. Make further changes for this version on this pull"
  echo "request."
  echo
  echo "Auto-merge with a merge commit is on. Approve this pull request and it merges once the checks pass. If auto-merge"
  echo "is off, merge with **Create a merge commit**, never with squash or rebase. The next version branch contains these"
  echo "commits, and with another merge method its release publishes them again."
  echo
  cat "${RUNNER_TEMP}/commits.md"
} >"${RUNNER_TEMP}/body.md"

# A rerun after a run that failed below finds the pull request already open
# and updates its commit list. --head matches by branch name only, so pull
# requests from forks are left out.
existing="$(GH_TOKEN="${DOCS_TOKEN}" gh pr list --repo TugboatQA/docs --head "${VERSION}" --state open \
  --json url,isCrossRepository --jq '[.[] | select(.isCrossRepository | not)][0].url // empty')"
if [ -n "${existing}" ]; then
  url="${existing}"
  GH_TOKEN="${DOCS_TOKEN}" gh pr edit "${url}" --body-file "${RUNNER_TEMP}/body.md" >/dev/null
  echo "Updated ${url}" >>"${GITHUB_STEP_SUMMARY}"
else
  url="$(GH_TOKEN="${DOCS_TOKEN}" gh pr create --repo TugboatQA/docs --base main --head "${VERSION}" \
    --title "Release ${VERSION}" --body-file "${RUNNER_TEMP}/body.md")"
  echo "Opened ${url}" >>"${GITHUB_STEP_SUMMARY}"
fi

# The next version branch contains these commits. After a squash or rebase
# merge, TugboatQA/docs main has them under other hashes, and the next release
# publishes them again. With auto-merge, GitHub merges with a merge commit once
# the pull request is approved and its checks pass.
if ! GH_TOKEN="${DOCS_TOKEN}" gh pr merge "${url}" --auto --merge; then
  echo "::warning::Auto-merge could not be turned on for ${url}. Merge it with Create a merge commit."
fi

# The pull request on TugboatQA/docs is now the only place for this version's
# documentation.
if ! gh api --method DELETE "repos/${GITHUB_REPOSITORY}/git/refs/heads/${VERSION}" --silent; then
  echo "::error::The pull request is open, but deleting ${VERSION} from ${GITHUB_REPOSITORY} failed. Delete the branch by hand."
  exit 1
fi
echo "Deleted \`${VERSION}\` from ${GITHUB_REPOSITORY}." >>"${GITHUB_STEP_SUMMARY}"
