# Container image that runs your code
FROM golang:1.15.8-alpine

RUN GO111MODULE=on go get -u github.com/sanjP10/release@3.2.0
# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
