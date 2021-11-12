FROM ruby:alpine

RUN echo 'gem: --no-document' >> /etc/gemrc \
  && apk add --no-cache libcurl # needed at runtime

ARG VERSION
RUN apk add --no-cache --virtual build-dependencies \
  build-base \
  libxml2-dev \
  libxslt-dev \
  && gem install html-proofer -v $VERSION \
  && apk del build-dependencies

ENTRYPOINT ["htmlproofer"]
CMD ["--help"]
