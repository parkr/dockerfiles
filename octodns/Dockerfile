FROM alpine as cloner
RUN apk update && apk add git
ARG GIT_REVISION
RUN git clone https://github.com/github/octodns /tmp/octodns && \
  git --git-dir=/tmp/octodns/.git --work-tree=/tmp/octodns checkout $GIT_REVISION

FROM python:2-alpine as build
COPY --from=cloner /tmp/octodns /usr/share/octodns
RUN pip install /usr/share/octodns boto3

FROM python:2-alpine
COPY --from=build /usr/local/lib/python2.7/site-packages /usr/local/lib/python2.7/site-packages
COPY --from=build /usr/local/bin/octodns-* /usr/local/bin/
CMD [ "/bin/sh" ]
