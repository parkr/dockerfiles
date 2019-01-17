ARG VERSION
FROM monicahq/monicahq:${VERSION}
RUN grep app_version /var/www/monica/config/monica.php
COPY 000-default.conf /etc/apache2/conf.d/000-default.conf
COPY 000-default.conf /var/www/monica/scripts/docker/000-default.conf
RUN sed -e 's/Listen 80/Listen 8080/' -i /etc/apache2/httpd.conf
RUN cat /etc/apache2/httpd.conf | grep Listen
ENTRYPOINT ["make", "-f", "/var/www/monica/scripts/docker/Makefile"]
