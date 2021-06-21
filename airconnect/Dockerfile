# https://github.com/philippe44/airconnect

FROM parkr/curl:latest as downloader
ENV AIRCONNECT_BINARY /usr/local/bin/airupnp-x86-64
ENV AIRCONNECT_BINARY_STATIC $AIRCONNECT_BINARY-static
ARG VERSION
RUN curl -o $AIRCONNECT_BINARY \
	  https://raw.githubusercontent.com/philippe44/AirConnect/$VERSION/bin/airupnp-x86-64 \
	&& chmod 755 $AIRCONNECT_BINARY \
&& curl -o $AIRCONNECT_BINARY_STATIC \
	  https://raw.githubusercontent.com/philippe44/AirConnect/$VERSION/bin/airupnp-x86-64-static \
	&& chmod 755 $AIRCONNECT_BINARY_STATIC

FROM debian:jessie-slim
RUN set -ex \
  && apt-get update -y \
  && apt-get install -y --no-install-recommends libssl-dev libssl1.0.0 strace \
  && rm -rf /var/lib/apt/lists/*
COPY healthcheck.sh /usr/local/bin/healthcheck.sh
HEALTHCHECK --interval=10s --timeout=30s --start-period=1s --retries=3 \
    CMD /usr/local/bin/healthcheck.sh
COPY --from=downloader $AIRCONNECT_BINARY $AIRCONNECT_BINARY
COPY --from=downloader $AIRCONNECT_BINARY_STATIC $AIRCONNECT_BINARY_STATIC
ENTRYPOINT [ "/usr/local/bin/airupnp-x86-64" ]
