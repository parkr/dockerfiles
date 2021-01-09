FROM ruby:alpine

RUN echo 'gem: --no-document' >> /etc/gemrc

# needed at runtime
RUN apk add --no-cache \
  libcurl

ARG VERSION
RUN apk add --no-cache --virtual build-dependencies \
  build-base \
  libxml2-dev \
  libxslt-dev \
  && gem install html-proofer -v $VERSION \
  && apk del build-dependencies

ENTRYPOINT ["htmlproofer"]
CMD ["--help"]
