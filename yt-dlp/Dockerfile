FROM parkr/curl:latest
WORKDIR /yt-dlp
RUN set -ex \
    && apk add --no-cache python3 \
    && rm -rf /var/cache/apk/* /etc/apk/* /lib/apk/* /usr/share/apk/*
ARG VERSION
RUN SUFFIX="$(bash yt-dlp-suffix)" \
  && curl -sLf \
    -o /usr/local/bin/yt-dlp \
    "https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp${SUFFIX}" \
  && chmod 755 /usr/local/bin/yt-dlp
ENTRYPOINT [ "/usr/local/bin/yt-dlp" ]
