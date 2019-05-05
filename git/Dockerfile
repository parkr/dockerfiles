FROM alpine:latest
RUN apk add --update git ca-certificates && rm -rf /var/cache/apk/*
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["git"]
