ARG VERSION
FROM monicahq/monicahq:${VERSION}
COPY 000-default.conf /etc/apache2/conf.d/000-default.conf
COPY 000-default.conf /var/www/monica/scripts/docker/000-default.conf
RUN set -ex \
  && sed -e 's/Listen 80/Listen 8080/' -i /etc/apache2/httpd.conf \
  && grep Listen /etc/apache2/httpd.conf \
  && sed -e 's/URL::forceScheme/\/\/ No longer forcing the scheme/' -i app/Providers/RouteServiceProvider.php \
  && grep -C 3 'production' app/Providers/RouteServiceProvider.php
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "apache2-foreground" ]
