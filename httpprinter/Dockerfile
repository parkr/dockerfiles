FROM golang:latest as builder
WORKDIR /app
COPY go.* /app/
COPY *.go /app/
RUN set -ex \
  && ls go.mod main.go \
  && CGO_ENABLED=0 go build -o /go/bin/httpprinter github.com/parkr/dockerfiles/httpprinter

FROM debian:stable-slim
COPY --from=builder /go/bin/httpprinter /bin/httpprinter
RUN set -ex \
    && apt-get update -y \
    && apt-get install --no-install-recommends -y bash curl ca-certificates wget \
    && rm -rf /var/cache/* /var/log/* /var/lib/dpkg/* /var/lib/apt/*
ENTRYPOINT [ "/bin/httpprinter" ]
