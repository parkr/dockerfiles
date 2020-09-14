ARG VERSION
FROM monica:${VERSION}-apache
WORKDIR /var/www/html
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN set -ex \
  && sed -e 's/Listen 80/Listen 8080/' -i /etc/apache2/ports.conf \
  && grep Listen /etc/apache2/ports.conf \
  && sed -e 's/URL::forceScheme/\/\/ No longer forcing the scheme/' -i app/Providers/RouteServiceProvider.php \
  && grep -C 3 'production' app/Providers/RouteServiceProvider.php
ENV CRON_LEGACY=true
COPY hourly-cron /etc/periodic/hourly/monica
COPY healthcheck.sh /usr/local/bin/healthcheck.sh
HEALTHCHECK --interval=10s --timeout=30s --start-period=1s --retries=3 \
  CMD /usr/local/bin/healthcheck.sh
WORKDIR /var/www/html
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "apache2-foreground" ]
