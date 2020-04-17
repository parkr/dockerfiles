FROM alpine:latest
RUN apk add --no-cache bash git ca-certificates && rm -rf /var/cache/apk/*
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["git"]
