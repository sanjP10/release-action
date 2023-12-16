# Container image that runs your code
FROM golang:1.21.5-alpine

RUN apk add build-base=0.5-r3 --no-cache && rm -rf /var/cache/apk/*
RUN go install github.com/sanjP10/release@3.2.2
# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
