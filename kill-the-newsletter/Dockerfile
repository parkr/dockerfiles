FROM parkr/git:latest as cloner
ARG VERSION
RUN set -ex \
  && git clone https://github.com/leafac/kill-the-newsletter.com /kill-the-newsletter \
  && git --git-dir=/kill-the-newsletter/.git --work-tree=/kill-the-newsletter checkout $VERSION \
  && rm -rf /kill-the-newsletter/.git
WORKDIR /kill-the-newsletter

# https://github.com/leafac/kill-the-newsletter.com/blob/master/Dockerfile
FROM node:slim

WORKDIR /kill-the-newsletter

RUN set -ex \
  && apt-get update -y \
  && apt-get install -y --no-install-recommends dumb-init \
  && rm -rf /var/lib/apt/lists/* \
  && which dumb-init

COPY --from=cloner /kill-the-newsletter/package*.json ./
RUN ls -lh && npm ci --production
COPY --from=cloner /kill-the-newsletter .

VOLUME /kill-the-newsletter/static/feeds/
VOLUME /kill-the-newsletter/static/alternate/

ENV WEB_PORT=8000
ENV EMAIL_PORT=2525
ENV BASE_URL=http://localhost:8000
ENV EMAIL_DOMAIN=localhost
ENV ISSUE_REPORT=mailto:kill-the-newsletter@leafac.com

EXPOSE 8000
EXPOSE 2525

# Most applications shouldn't be run as PID 1, so we use dumb-init to take over PID 1 duties.
# Furthermore, we will rewrite SIGTERM (15) to SIGINT (2)
ENTRYPOINT ["/usr/bin/dumb-init", "--rewrite", "15:2", "--"]

CMD [ "npm", "start" ]
