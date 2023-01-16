FROM alpine:latest as downloader
RUN apk add --no-cache curl
WORKDIR /tmp
ARG VERSION
RUN set -ex \
  && curl --silent --location --fail --output /tmp/writefreely_$VERSION_linux_amd64.tar.gz https://github.com/writefreely/writefreely/releases/download/v$VERSION/writefreely_$VERSION_linux_amd64.tar.gz
  && tar -xzvf /tmp/writefreely_$VERSION_linux_amd64.tar.gz \
  && ls /tmp \
  && cp /tmp/writefreely_$VERSION_linux_amd64/writefreely /usr/local/bin/writefreely \
  && chmod +x /usr/local/bin/writefreely

FROM cgr.dev/chainguard/static:latest
COPY --from=downloader /usr/local/bin/writefreely /usr/local/bin/writefreely
ENTRYPOINT [ "/usr/local/bin/writefreely" ]
