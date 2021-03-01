#!/bin/sh -l

set -o pipefail
$GOPATH/bin/release $1 -username $2 -password $3 -repo $GITHUB_REPOSITORY -changelog $GITHUB_WORKSPACE/$4 -hash $GITHUB_SHA -provider github | tee version.txt
echo "::set-output name=version::$(cat version.txt)"
