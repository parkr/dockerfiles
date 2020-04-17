FROM golang:latest as builder
RUN set -ex \
  && CGO_ENABLED=0 go get github.com/parkr/silence-but-for-error/cmd/silence-but-for-error

FROM debian:stable-slim
COPY --from=builder /go/bin/silence-but-for-error /bin/silence-but-for-error
RUN set -ex \
    && apt-get update -y \
    && apt-get install --no-install-recommends -y bash curl ca-certificates wget \
    && rm -rf /var/cache/* /var/log/* /var/lib/dpkg/* /var/lib/apt/*
ENTRYPOINT [ "/bin/silence-but-for-error" ]
