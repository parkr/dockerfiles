FROM alpine:latest
RUN apk add --update bash curl ca-certificates && rm -rf /var/cache/apk/*
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["curl"]
