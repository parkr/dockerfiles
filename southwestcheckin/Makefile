# https://hub.docker.com/r/monicahq/monicahq/tags/
REVISION:=e4c40a3810a73f54c7126c4bcd81837a6013d599

TAG:=$(REVISION)
DOCKERFILE:=Dockerfile
IMAGE:=parkr/southwestcheckin:$(TAG)

all: build

build:
	docker build -t $(IMAGE) -f $(DOCKERFILE) --build-arg GIT_REVISION=$(REVISION) .

test: build
	docker run -it --rm $(IMAGE) --help

publish: build
	docker push $(IMAGE)
