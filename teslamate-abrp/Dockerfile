FROM python:3.12.4-alpine as cloner

RUN set -ex \
    && apk add --no-cache git
ENV CHECKOUT_DIR /usr/src/teslamate-abrp
RUN git clone https://github.com/fetzu/teslamate-abrp ${CHECKOUT_DIR}
WORKDIR $CHECKOUT_DIR
ARG VERSION
RUN set -ex \
    && git checkout -q "$VERSION" \
    && [ "$(git --work-tree=$CHECKOUT_DIR --git-dir=$CHECKOUT_DIR/.git describe --tags)" = "$VERSION" ] \
    && ls

FROM python:3.12.4-alpine

WORKDIR /usr/src/teslamate-abrp
COPY --from=cloner /usr/src/teslamate-abrp/LICENSE ./
COPY --from=cloner /usr/src/teslamate-abrp/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY --from=cloner /usr/src/teslamate-abrp/teslamate_mqtt2abrp.py ./

CMD [ "python", "-u", "./teslamate_mqtt2abrp.py" ]
