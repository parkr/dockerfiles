FROM parkr/curl:latest
WORKDIR /yt-dlp
RUN set -ex \
    && apk add --no-cache python3 ffmpeg \
    && rm -rf /var/cache/apk/* /etc/apk/* /lib/apk/* /usr/share/apk/*
ARG VERSION
RUN curl -sLf \
    -o /usr/local/bin/yt-dlp \
    "https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp" \
  && chmod 755 /usr/local/bin/yt-dlp
ENTRYPOINT [ "/usr/local/bin/yt-dlp" ]
