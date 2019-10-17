FROM golang:alpine as builder
ARG VERSION
RUN set -ex \
    && apk add --no-cache git bash gcc sqlite libc-dev
ENV CHECKOUT_DIR /go/src/github.com/sourcegraph/checkup
RUN set -ex \
    && go get -d github.com/sourcegraph/checkup/... \
    && git --work-tree=$CHECKOUT_DIR --git-dir=$CHECKOUT_DIR/.git checkout -q $VERSION \
    && [  "$(git --work-tree=$CHECKOUT_DIR --git-dir=$CHECKOUT_DIR/.git rev-parse HEAD)" = $VERSION ] \
    && go version \
    && GOOS=linux go install -v -ldflags "-w -s" github.com/sourcegraph/checkup/...

FROM alpine
COPY --from=builder /go/bin/checkup /bin/checkup
ENTRYPOINT [ "/bin/checkup" ]
