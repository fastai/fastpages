#!/bin/sh

# Make a comment on a PR.
# Usage:
# > pr_comment.sh <<Text Comment>>

set -e

# This is populated by our secret from the Workflow file.
if [[ -z "${GITHUB_TOKEN}" ]]; then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

if [[ -z "${ISSUE_NUMBER}" ]]; then
	echo "Set the ISSUE_NUMBER env variable."
	exit 1
fi

if [ -z "$1" ]
  then
    echo "No MESSAGE argument supplied.  Usage: issue_comment.sh <message>"
    exit 1
fi

MESSAGE=$1

## Set Vars
URI=https://api.github.com
API_VERSION=v3
API_HEADER="Accept: application/vnd.github.${API_VERSION}+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

# Create a comment with APIv3 # POST /repos/:owner/:repo/issues/:issue_number/comments
curl -XPOST -sSL \
    -d "{\"body\": \"$MESSAGE\"}" \
    -H "${AUTH_HEADER}" \
    -H "${API_HEADER}" \
    "${URI}/repos/${GITHUB_REPOSITORY}/issues/${ISSUE_NUMBER}/comments"
