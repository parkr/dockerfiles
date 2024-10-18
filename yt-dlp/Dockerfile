FROM parkr/curl:latest
WORKDIR /yt-dlp
COPY yt-dlp-artifact-suffix.sh .
ARG VERSION
RUN SUFFIX="$(bash yt-dlp-artifact-suffix.sh)" \
  && curl -sLf \
    -o /usr/local/bin/yt-dlp \
    "https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp${SUFFIX}" \
  && chmod 755 /usr/local/bin/yt-dlp
ENTRYPOINT [ "/usr/local/bin/yt-dlp" ]
