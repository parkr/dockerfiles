FROM python:3.10-alpine as cloner

RUN set -ex \
    && apk add --no-cache git
ENV CHECKOUT_DIR /usr/src/teslamate-abrp
RUN git clone https://github.com/fetzu/teslamate-abrp ${CHECKOUT_DIR}
WORKDIR $CHECKOUT_DIR
RUN set -ex \
    && git checkout -q "$VERSION" \
    && [ "$(git --work-tree=$CHECKOUT_DIR --git-dir=$CHECKOUT_DIR/.git rev-parse HEAD)" = "$VERSION" ] \
    && ls

FROM python:3.10-alpine

COPY --from=cloner LICENSE ./
COPY --from=cloner requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY --from=cloner teslamate_mqtt2abrp.py ./

CMD [ "python", "-u", "./teslamate_mqtt2abrp.py" ]
