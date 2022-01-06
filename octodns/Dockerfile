FROM python:3.10-slim as build
RUN set -ex \
  && apt-get -y update \
  && apt-get -y install --no-install-recommends git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ARG VERSION
RUN pip install --no-cache-dir boto3 \
  git+https://github.com/octodns/octodns@237610d3a953059b112967d896c400148df0c466 \
  git+https://github.com/octodns/octodns-cloudflare@e659d2da3e57a22eeed601c3b62458e61a0dd9b2

FROM python:3.10-slim
COPY --from=build /usr/local/lib/python*/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=build /usr/local/bin/octodns-* /usr/local/bin/
CMD [ "/bin/sh" ]
