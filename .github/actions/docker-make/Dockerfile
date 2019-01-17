# Inspiration from https://github.com/actions/docker/blob/master/cli/Dockerfile
FROM docker:stable

RUN apk add --update make bash && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]