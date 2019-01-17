FROM golang
ARG VERSION
ENV CHECKOUT_DIR /go/src/github.com/sourcegraph/checkup
RUN set -ex \
    && go get -d github.com/sourcegraph/checkup/... \
    && git --work-tree=$CHECKOUT_DIR --git-dir=$CHECKOUT_DIR/.git checkout -q $VERSION \
    && [  "$(git --work-tree=$CHECKOUT_DIR --git-dir=$CHECKOUT_DIR/.git rev-parse HEAD)" = $VERSION ] \
    && CGO_ENABLED=0 GOOS=linux go install -v github.com/sourcegraph/checkup/...

FROM scratch
COPY --from=0 /go/bin/checkup /bin/checkup
ENTRYPOINT [ "/bin/checkup" ]
