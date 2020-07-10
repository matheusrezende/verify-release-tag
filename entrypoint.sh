#!/bin/bash

set -e
set -o pipefail

echo "Start validation $1"

BRANCH=$(git branch -r --contains ${GITHUB_SHA} | grep "")
RELEASE_VERSION=$(echo ${GITHUB_REF} | sed -e "s/refs\/tags\///g" | sed -e "s/\//-/g")

MASTER_BRANCH_NAME='origin/master'
RELEASE_PREFIX='r-'

if [[ "${INPUT_PRERELEASE}" != true ]] && [[ "$BRANCH" == *"$MASTER_BRANCH_NAME"* ]] && [[ "$RELEASE_VERSION" == "$RELEASE_PREFIX"* ]]; then
  echo "Release tag validation succeeded!"
  exit 0
elif [[ "${INPUT_PRERELEASE}" == true ]]; then
  echo "Pre-Release tag validation succeeded!"
  exit 0
else
  echo "Tag validation failed!"
  exit 1
fi
