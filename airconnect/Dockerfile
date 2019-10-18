# https://github.com/philippe44/airconnect

FROM parkr/curl:latest as downloader
ENV AIRCONNECT_BINARY /usr/local/bin/airupnp-x86-64
ARG VERSION
RUN curl -o $AIRCONNECT_BINARY \
	  https://raw.githubusercontent.com/philippe44/AirConnect/$VERSION/bin/airupnp-x86-64 \
	&& chmod 755 $AIRCONNECT_BINARY

FROM debian:jessie-slim
RUN set -ex \
  && apt-get update -y \
  && apt-get install -y --no-install-recommends libssl-dev libssl1.0.0 strace \
  && rm -rf /var/lib/apt/lists/*
COPY healthcheck.sh /usr/local/bin/healthcheck.sh
HEALTHCHECK --interval=10s --timeout=30s --start-period=1s --retries=3 \
    CMD /usr/local/bin/healthcheck.sh
COPY --from=downloader $AIRCONNECT_BINARY $AIRCONNECT_BINARY
ENTRYPOINT [ "/usr/local/bin/airupnp-x86-64" ]
