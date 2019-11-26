FROM golang:alpine
ARG VERSION
RUN set -ex \
    && apk add -U alpine-sdk linux-headers \
    && curl ftp://ftp.isc.org/isc/bind9/9.10.2/bind-9.10.2.tar.gz|tar -xzv \
    && cd bind-9.10.2 \
    && CFLAGS="-static" ./configure --without-openssl --disable-symtable \
    && make \
    && cp ./bin/dig/dig /usr/bin/ \
    && apk del alpine-sdk linux-headers \
    && rm -rf bind-9.10.2/
RUN set -ex \
    && apk add --no-cache git build-base \
    && git clone https://github.com/cloudflare/cloudflared /go/src/github.com/cloudflare/cloudflared \
    && cd /go/src/github.com/cloudflare/cloudflared \
    && if [ "$VERSION" = "latest" ]; then git checkout master; else git checkout "$VERSION"; fi \
    && go install github.com/cloudflare/cloudflared/cmd/cloudflared

FROM golang:alpine
COPY healthcheck_dns_proxy.sh /bin/healthcheck_dns_proxy.sh
COPY --from=0 /usr/bin/dig /bin/dig
COPY --from=0 /go/bin/cloudflared /bin/cloudflared
ENTRYPOINT [ "/bin/cloudflared" ]
