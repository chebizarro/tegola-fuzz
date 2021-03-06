# Based on the Dockerfile in the Tegola source tree
# --- Build the binary
FROM golang:1.9.2-alpine3.7 AS build
RUN apk update
RUN apk add git
RUN apk add musl-dev=1.1.18-r3
RUN apk add gcc=6.4.0-r5

ENV GOPATH=/opt
ENV PATH=$PATH:$GOPATH/bin
RUN go get -u github.com/dvyukov/go-fuzz/...
RUN mkdir -p /opt/src/github.com/go-spatial
RUN mkdir -p /opt/fuzzing
COPY corpus /opt/fuzzing/corpus

RUN git clone -b issue-53-fuzzing --single-branch https://github.com/chebizarro/tegola.git \
	/opt/src/github.com/go-spatial/tegola

RUN go-fuzz-build github.com/go-spatial/tegola/geom/encoding/wkb

#RUN go-fuzz -bin=./wkb-fuzz.zip -workdir=/opt/fuzzing
