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
# commit messages with references such as #123 or @name mentions, which link to
# the wrong items or notify people once they are in TugboatQA/docs.
#
# Required environment variables, besides the ones GitHub Actions sets:
#   GH_TOKEN    Token with contents: read on TugboatQA/docs-private
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

if [ "${DRY_RUN}" = "true" ]; then
  echo "Dry run. Nothing was pushed." >>"${GITHUB_STEP_SUMMARY}"
  exit 0
fi

# The push is rejected if the branch on TugboatQA/docs has commits that this
# one lacks, for example a merge of main made on the release pull request.
if ! git push "https://x-access-token:${DOCS_TOKEN}@github.com/TugboatQA/docs.git" "${head}:refs/heads/${VERSION}"; then
  echo "::error::The push failed. If ${VERSION} on TugboatQA/docs has commits that this branch lacks, make further changes on the release pull request there."
  exit 1
fi
export GH_TOKEN="${DOCS_TOKEN}"

{
  echo "Releases the documentation for Tugboat ${VERSION}, written in TugboatQA/docs-private."
  echo
  echo "Merge with **Create a merge commit**, then delete the \`${VERSION}\` branch here and in TugboatQA/docs-private."
  echo
  cat "${RUNNER_TEMP}/commits.md"
} >"${RUNNER_TEMP}/body.md"

# A rerun pushes new commits to the pull request that is already open, and
# updates its commit list. --head matches by branch name only, so pull requests
# from forks are left out.
existing="$(gh pr list --repo TugboatQA/docs --head "${VERSION}" --state open --json url,isCrossRepository \
  --jq '[.[] | select(.isCrossRepository | not)][0].url // empty')"
if [ -n "${existing}" ]; then
  gh pr edit "${existing}" --body-file "${RUNNER_TEMP}/body.md" >/dev/null
  echo "Updated ${existing}" >>"${GITHUB_STEP_SUMMARY}"
  exit 0
fi

url="$(gh pr create --repo TugboatQA/docs --base main --head "${VERSION}" \
  --title "Release ${VERSION}" --body-file "${RUNNER_TEMP}/body.md")"
echo "Opened ${url}" >>"${GITHUB_STEP_SUMMARY}"
