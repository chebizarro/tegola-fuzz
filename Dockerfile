# Based on the Dockerfile in the Tegola source tree
# --- Build the binary
FROM golang:1.9.2-alpine3.7 AS build
RUN apk update
RUN apk add git
RUN apk add musl-dev=1.1.18-r3
RUN apk add gcc=6.4.0-r5

ENV GOPATH=/opt
RUN go get -u github.com/dvyukov/go-fuzz/...
RUN mkdir -p /opt/src/github.com/go-spatial
RUN git clone -b issue-53-fuzzing --single-branch https://github.com/chebizarro/tegola.git \
	/opt/src/github.com/go-spatial
RUN go-fuzz-build src/github.com/go-spatial/wkb
RUN ls -la
