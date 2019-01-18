FROM alpine as cloner
RUN apk update && apk add --no-cache git
ARG VERSION
ENV CHECKOUT_DIR /tmp/SouthwestCheckin
RUN set -ex \
    && git clone https://github.com/pyro2927/SouthwestCheckin $CHECKOUT_DIR \
    && git --work-tree=$CHECKOUT_DIR --git-dir=$CHECKOUT_DIR/.git checkout -q $VERSION \
    && [  "$(git --work-tree=$CHECKOUT_DIR --git-dir=$CHECKOUT_DIR/.git rev-parse HEAD)" = $VERSION ]

FROM python:3.6-alpine
COPY --from=cloner /tmp/SouthwestCheckin /tmp/SouthwestCheckin
WORKDIR /tmp/SouthwestCheckin
RUN pip install -r requirements.txt
ENTRYPOINT [ "python", "/tmp/SouthwestCheckin/checkin.py" ]
