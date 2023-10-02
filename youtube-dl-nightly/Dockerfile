FROM parkr/curl:latest
WORKDIR /youtube-dl
RUN set -ex \
    && apk add --no-cache python3 \
    && rm -rf /var/cache/apk/* /etc/apk/* /lib/apk/* /usr/share/apk/*
ARG VERSION
RUN curl -sLf \
    -o /tmp/youtube-dl-nightly.tar.gz \
    https://github.com/ytdl-org/ytdl-nightly/releases/download/$VERSION/youtube-dl-$VERSION.tar.gz \
  && tar -C /usr/local/share -xzvf /tmp/youtube-dl-nightly.tar.gz \
  && ln -s /usr/local/share/youtube-dl/youtube-dl /usr/local/bin/youtube-dl
ENTRYPOINT [ "/usr/local/bin/youtube-dl" ]