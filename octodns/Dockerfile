FROM alpine as cloner
RUN apk update && apk add git
ARG VERSION
ENV CHECKOUT_DIR /tmp/octodns
RUN set -ex \
    && git clone https://github.com/github/octodns $CHECKOUT_DIR \
    && git --work-tree=$CHECKOUT_DIR --git-dir=$CHECKOUT_DIR/.git checkout -q $VERSION \
    && [  "$(git --work-tree=$CHECKOUT_DIR --git-dir=$CHECKOUT_DIR/.git rev-parse HEAD)" = $VERSION ]

FROM python:2-alpine as build
COPY --from=cloner /tmp/octodns /usr/share/octodns
RUN pip install /usr/share/octodns boto3

FROM python:2-alpine
COPY --from=build /usr/local/lib/python2.7/site-packages /usr/local/lib/python2.7/site-packages
COPY --from=build /usr/local/bin/octodns-* /usr/local/bin/
CMD [ "/bin/sh" ]
