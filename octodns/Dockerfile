FROM alpine as cloner
RUN apk update && apk add git
ARG VERSION
ENV CHECKOUT_DIR /tmp/octodns
RUN set -ex \
    && [ -n $VERSION ] \
    && git clone https://github.com/github/octodns $CHECKOUT_DIR \
    && cd $CHECKOUT_DIR \
    && git fetch origin refs/pull/402/head \
    && git checkout -q $VERSION

FROM python:2-alpine as build
COPY --from=cloner /tmp/octodns /usr/share/octodns
RUN pip install /usr/share/octodns boto3

FROM python:2-alpine
COPY --from=build /usr/local/lib/python2.7/site-packages /usr/local/lib/python2.7/site-packages
COPY --from=build /usr/local/bin/octodns-* /usr/local/bin/
CMD [ "/bin/sh" ]
