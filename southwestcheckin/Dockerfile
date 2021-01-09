FROM alpine:latest as cloner
RUN apk update && apk add --no-cache git
ARG VERSION
ENV CHECKOUT_DIR /app/SouthwestCheckin
RUN set -ex \
    && git clone https://github.com/pyro2927/SouthwestCheckin $CHECKOUT_DIR \
    && git --work-tree=$CHECKOUT_DIR --git-dir=$CHECKOUT_DIR/.git checkout -q $VERSION \
    && [  "$(git --work-tree=$CHECKOUT_DIR --git-dir=$CHECKOUT_DIR/.git rev-parse HEAD)" = $VERSION ] \
    && rm -rf $CHECKOUT_DIR/.git

FROM python:3.7-alpine
COPY --from=cloner /app/SouthwestCheckin /app/SouthwestCheckin
WORKDIR /app/SouthwestCheckin
RUN set -ex \
  && apk add --no-cache build-base \
  && pip install --no-cache-dir -r requirements.txt \
  && rm -rf /root/.cache
ENTRYPOINT [ "/app/SouthwestCheckin/entrypoint.sh" ]
