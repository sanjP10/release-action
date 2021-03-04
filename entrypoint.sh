#!/bin/sh -l

set -o pipefail

if [ ! -z $5 ]
  $GOPATH/bin/release $1 -username $2 -password $3 -repo $GITHUB_REPOSITORY -changelog $GITHUB_WORKSPACE/$4 -hash $GITHUB_SHA -provider github -host $5 | tee version.txt
then
  $GOPATH/bin/release $1 -username $2 -password $3 -repo $GITHUB_REPOSITORY -changelog $GITHUB_WORKSPACE/$4 -hash $GITHUB_SHA -provider github | tee version.txt
fi
echo "::set-output name=version::$(cat version.txt)"
