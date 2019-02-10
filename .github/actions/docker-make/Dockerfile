# Inspiration from https://github.com/actions/docker/blob/master/cli/Dockerfile
FROM docker:stable

RUN apk add --update make bash jq curl && rm -rf /var/cache/apk/*

COPY docker_tag_exists.sh /docker_tag_exists.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
