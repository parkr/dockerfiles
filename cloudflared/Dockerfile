FROM golang:alpine as builder
ARG VERSION
COPY healthcheck.go /go/src/cloudflared-healthcheck/main.go
RUN set -ex \
    && go build -o /go/bin/cloudflared-healthcheck /go/src/cloudflared-healthcheck/main.go
# hadolint ignore=DL3003
RUN set -ex \
    && apk add --no-cache git build-base \
    && git clone https://github.com/cloudflare/cloudflared /go/src/github.com/cloudflare/cloudflared \
    && cd /go/src/github.com/cloudflare/cloudflared \
    && if [ "$VERSION" = "latest" ]; then git checkout master; else git checkout "$VERSION"; fi \
    && go install github.com/cloudflare/cloudflared/cmd/cloudflared

FROM golang:alpine
COPY --from=builder /go/bin/cloudflared-healthcheck /bin/cloudflared-healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "/bin/cloudflared-healthcheck" ]
COPY --from=builder /go/bin/cloudflared /bin/cloudflared
ENTRYPOINT [ "/bin/cloudflared" ]
