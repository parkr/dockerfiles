FROM golang:alpine as builder
ARG VERSION
RUN set -ex \
    && apk add --no-cache git
ENV CHECKOUT_DIR /go/src/github.com/sourcegraph/checkup
RUN git clone https://github.com/sourcegraph/checkup ${CHECKOUT_DIR}
WORKDIR $CHECKOUT_DIR
RUN set -ex \
    && git checkout -q $VERSION \
    && [ "$(git --work-tree=$CHECKOUT_DIR --git-dir=$CHECKOUT_DIR/.git rev-parse HEAD)" = $VERSION ] \
    && go version \
    && GOOS=linux go build -o /go/bin/checkup -v -ldflags "-w -s" "github.com/sourcegraph/checkup/cmd/checkup"

FROM alpine:latest
COPY --from=builder /go/bin/checkup /bin/checkup
ENTRYPOINT [ "/bin/checkup" ]
