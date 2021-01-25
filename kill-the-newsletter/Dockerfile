FROM parkr/git:latest as cloner
ARG VERSION
RUN set -ex \
  && git clone github.com/leafac/kill-the-newsletter /kill-the-newsletter \
  && cd /kill-the-newsletter \
  && git checkout $VERSION \
  && rm -rf /kill-the-newsletter/.git
WORKDIR /kill-the-newsletter

# https://github.com/leafac/kill-the-newsletter.com/blob/master/Dockerfile
FROM node:slim

WORKDIR /kill-the-newsletter

COPY --from=cloner package*.json ./
RUN npm ci --production
COPY --from=cloner . .

VOLUME /kill-the-newsletter/static/feeds/
VOLUME /kill-the-newsletter/static/alternate/

ENV WEB_PORT=8000
ENV EMAIL_PORT=2525
ENV BASE_URL=http://localhost:8000
ENV EMAIL_DOMAIN=localhost
ENV ISSUE_REPORT=mailto:kill-the-newsletter@leafac.com

EXPOSE 8000
EXPOSE 2525

CMD npm start
