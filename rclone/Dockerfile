FROM alpine:latest as downloader
RUN apk add --no-cache curl
WORKDIR /tmp
ARG VERSION
RUN set -ex \
  && curl --fail --silent --location --output /tmp/rclone-$VERSION-linux-amd64.zip https://github.com/rclone/rclone/releases/download/$VERSION/rclone-$VERSION-linux-amd64.zip \
  && unzip /tmp/rclone-$VERSION-linux-amd64.zip \
  && cp /tmp/rclone-$VERSION-linux-amd64/rclone /usr/local/bin/rclone \
  && chmod +x /usr/local/bin/rclone

FROM scratch
COPY --from=downloader /usr/local/bin/rclone /usr/local/bin/rclone
ENTRYPOINT [ "/usr/local/bin/rclone" ]
