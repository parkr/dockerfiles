REV:=b5474a486a8a12449fa163ff13f921f130ff1a95

AIRUPNP_DOCKERFILE:=Dockerfile-airupnp-$(REV)
AIRUPNP_BINARY:=airupnp-x86-64-$(REV)

all: airupnp

clean:
	rm -f Dockerfile* airupnp*

$(AIRUPNP_BINARY):
	wget -O $(AIRUPNP_BINARY) \
	  https://raw.githubusercontent.com/philippe44/AirConnect/$(REV)/bin/airupnp-x86-64
	chmod 755 $(AIRUPNP_BINARY)

$(AIRUPNP_DOCKERFILE):
	@echo "FROM ubuntu" > $(AIRUPNP_DOCKERFILE)
	@echo "RUN apt-get update -y && apt-get install -y libssl-dev && rm -rf /var/lib/apt/lists/*" >> $(AIRUPNP_DOCKERFILE)
	@echo "ADD $(AIRUPNP_BINARY) /bin/$(AIRUPNP_BINARY)" >> $(AIRUPNP_DOCKERFILE)
	@echo "ENTRYPOINT /bin/$(AIRUPNP_BINARY)" >> $(AIRUPNP_DOCKERFILE)

airupnp: $(AIRUPNP_BINARY) $(AIRUPNP_DOCKERFILE)
	docker build -t parkr/airupnp:$(REV) -f $(AIRUPNP_DOCKERFILE) .

airupnp-test: airupnp
	docker run -it --rm parkr/airupnp:$(REV) -m squeezebox -l 1000:2000 -z
