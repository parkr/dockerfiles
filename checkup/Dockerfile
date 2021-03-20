FROM golang:alpine as builder
ARG VERSION
RUN set -ex \
    && apk add --no-cache git
ENV CHECKOUT_DIR /go/src/github.com/sourcegraph/checkup
RUN set -ex \
    && git clone https://github.com/sourcegraph/checkup ${CHECKOUT_DIR} \
    && cd ${CHECKOUT_DIR} \
    && git checkout -q $VERSION \
    && [ "$(git --work-tree=$CHECKOUT_DIR --git-dir=$CHECKOUT_DIR/.git rev-parse HEAD)" = $VERSION ] \
    && go mod download \
    && go version \
    && GOOS=linux go install -v -ldflags "-w -s" github.com/sourcegraph/checkup/...

FROM alpine:latest
COPY --from=builder /go/bin/checkup /bin/checkup
ENTRYPOINT [ "/bin/checkup" ]
