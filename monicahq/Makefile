# https://hub.docker.com/r/monicahq/monicahq/tags/
VERSION:=v2.10.2
REV:=1

TAG:=$(VERSION)-$(REV)
DOCKERFILE:=Dockerfile-$(VERSION)-$(REV)
IMAGE:=parkr/monicahq:$(TAG)

all: monicahq

clean:
	rm -f Dockerfile*

$(DOCKERFILE):
	@echo "FROM monicahq/monicahq:$(VERSION)" > $(DOCKERFILE)
	@echo "ADD 000-default.conf /etc/apache2/conf.d/000-default.conf" >> $(DOCKERFILE)
	@echo "ADD 000-default.conf /var/www/monica/scripts/docker/000-default.conf" >> $(DOCKERFILE)
	@echo "RUN sed -e 's/Listen 80/Listen 8080/' -i /etc/apache2/httpd.conf" >> $(DOCKERFILE)
	@echo "RUN cat /etc/apache2/httpd.conf | grep Listen" >> $(DOCKERFILE)
	@echo 'ENTRYPOINT ["make", "-f", "/var/www/monica/scripts/docker/Makefile"]' >> $(DOCKERFILE)

monicahq: $(DOCKERFILE)
	docker build -t $(IMAGE) -f $(DOCKERFILE) .

monicahq-test: monicahq
	docker run -it --rm $(IMAGE)

publish: monicahq
	docker push $(IMAGE)
