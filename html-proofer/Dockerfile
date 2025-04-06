FROM ruby:alpine

RUN echo 'gem: --no-document' >> /etc/gemrc \
  && apk add --no-cache libcurl # needed at runtime

ARG VERSION
RUN set -ex \
  && apk add --no-cache libxml2 libxslt linux-headers \
  && apk add --no-cache --virtual .gem-installdeps build-base libxml2-dev libxslt-dev \
  && gem install html-proofer -v "$VERSION" --platform=ruby -- --use-system-libraries \
  && rm -rf "$GEM_HOME"/cache \
  && apk del .gem-installdeps

ENTRYPOINT ["htmlproofer"]
CMD ["--help"]
