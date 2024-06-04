#!/usr/bin/env bash

set -eux

# Support private repositories.

if [[ ! -z "${GITHUB_AUTHENTICATION_TOKEN}" ]]; then
    git config --global --add url."https://x-access-token:${GITHUB_AUTHENTICATION_TOKEN}@github.com/".insteadOf "https://github.com/"
fi

# Apply hotfix for 'fatal: unsafe repository' error.

git config --global --add safe.directory "${GITHUB_WORKSPACE}"

# Required git configuration.

git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

# Make the tag.

cd "${GITHUB_WORKSPACE}" || exit
export MAJOR_VERSION=$(echo ${GITHUB_REF_NAME} | cut -d. -f1)
export MAJOR_V_VERSION="v${MAJOR_VERSION}"
export GIT_SHA=$(git rev-list -n 1 ${GIT_TAG})
git ls-remote --tags
git tag -d ${MAJOR_V_VERSION}
git push origin :refs/tags/${MAJOR_V_VERSION}
git tag -a "${MAJOR_V_VERSION}" -m "Updating mutable tag version ${MAJOR_V_VERSION}" ${GIT_SHA}
git push origin tag ${MAJOR_V_VERSION}
