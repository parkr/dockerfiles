FROM alpine:3.6
ARG VERSION
RUN apk -v --no-cache add \
        python \
        py-pip \
        groff \
        less \
        mailcap \
        && \
    pip install --upgrade pip && \
    pip install --upgrade awscli==$VERSION s3cmd==2.0.1 python-magic && \
    apk -v --purge del py-pip
VOLUME /root/.aws
VOLUME /project
WORKDIR /project
ENTRYPOINT ["aws"]
