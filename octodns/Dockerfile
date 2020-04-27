FROM alpine:latest as cloner
RUN apk add --no-cache git && rm -rf /var/cache/apk/*
ARG VERSION
ENV CHECKOUT_DIR /tmp/octodns
RUN set -ex \
    && [ -n "$VERSION" ] \
    && git clone https://github.com/github/octodns $CHECKOUT_DIR \
    && git --work-tree "$CHECKOUT_DIR" --git-dir="$CHECKOUT_DIR/.git" checkout -q "$VERSION"

FROM python:3-slim as build
COPY --from=cloner /tmp/octodns /usr/share/octodns
RUN pip install /usr/share/octodns boto3

FROM python:3-slim
COPY --from=build /usr/local/lib/python*/site-packages /usr/local/lib/python3.8/site-packages
COPY --from=build /usr/local/bin/octodns-* /usr/local/bin/
CMD [ "/bin/sh" ]
