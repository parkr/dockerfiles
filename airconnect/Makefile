# https://github.com/philippe44/airconnect
REV:=20fab815f075645cdb7f320f5addbc1790b18dff
VERSION:=2

DOCKER_TAG:=$(REV)-$(VERSION)
DOCKERFILE:=Dockerfile-$(DOCKER_TAG)
DOCKER_IMAGE:=parkr/airupnp:$(DOCKER_TAG)
AIRUPNP_BINARY:=airupnp-x86-64-$(REV)
CWD:=$(shell pwd)
CONFIG_FILE:=$(CWD)/config.xml

all: airupnp

clean:
	rm -f Dockerfile* airupnp*

$(AIRUPNP_BINARY):
	wget -O $(AIRUPNP_BINARY) \
	  https://raw.githubusercontent.com/philippe44/AirConnect/$(REV)/bin/airupnp-x86-64
	chmod 755 $(AIRUPNP_BINARY)

$(DOCKERFILE):
	@echo "FROM debian:jessie-slim" > $(DOCKERFILE)
	@echo "RUN apt-get update -y && \\ " >> $(DOCKERFILE)
	@echo " apt-get install -y libssl-dev libssl1.0.0 strace && \\ " >> $(DOCKERFILE)
	@echo " rm -rf /var/lib/apt/lists/*" >> $(DOCKERFILE)
	@echo "COPY $(AIRUPNP_BINARY) /bin/$(AIRUPNP_BINARY)" >> $(DOCKERFILE)
	@echo "ENTRYPOINT [ \"/bin/$(AIRUPNP_BINARY)\" ] " >> $(DOCKERFILE)

airupnp: $(AIRUPNP_BINARY) $(DOCKERFILE)
	docker build -t $(DOCKER_IMAGE) -f $(DOCKERFILE) .

airupnp-test: airupnp
	docker run -v $(CONFIG_FILE):$(CONFIG_FILE) --rm --net=host $(DOCKER_IMAGE) -Z -z -x $(CONFIG_FILE)

airupnp-debug: airupnp
	docker run -v $(CONFIG_FILE):$(CONFIG_FILE) \
		--cap-add sys_admin \
		--cap-add sys_ptrace \
		--entrypoint strace \
		--rm \
		--net=host \
		$(DOCKER_IMAGE) \
		-f /bin/$(AIRUPNP_BINARY) -Z -z -x $(CONFIG_FILE)

publish: airupnp
	docker push $(DOCKER_IMAGE)
