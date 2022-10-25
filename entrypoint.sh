#!/bin/sh -l

if [ ! -z $5 ]
then
  version=$($GOPATH/bin/release $1 -username $2 -password $3 -repo $GITHUB_REPOSITORY -changelog $GITHUB_WORKSPACE/$4 -hash $GITHUB_SHA -provider github -host $5) || exit $?
else
  version=$($GOPATH/bin/release $1 -username $2 -password $3 -repo $GITHUB_REPOSITORY -changelog $GITHUB_WORKSPACE/$4 -hash $GITHUB_SHA -provider github) || exit $?
fi
echo "version=$version" >> $GITHUB_OUTPUT
