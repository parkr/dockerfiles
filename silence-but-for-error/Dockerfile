FROM golang:alpine as builder
RUN set -ex \
  && apk add --no-cache --update git \
  && go get github.com/parkr/silence-but-for-error/cmd/silence-but-for-error

FROM alpine
COPY --from=builder /go/bin/silence-but-for-error /bin/silence-but-for-error
RUN set -ex \
    && apk add --update --no-cache bash curl ca-certificates wget \
    && rm -rf /var/cache/apk/*
ENTRYPOINT [ "/bin/silence-but-for-error" ]
