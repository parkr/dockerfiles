REVISION:=c0730918a6abe1ba78b720b3d398c4e818d98b1a

TAG:=$(REVISION)
DOCKERFILE:=Dockerfile
IMAGE:=parkr/octodns:$(TAG)

all: build

build:
	docker build -t $(IMAGE) -f $(DOCKERFILE) --build-arg GIT_REVISION=$(REVISION) .

test: build
	docker run -it --rm $(IMAGE) which \
	  octodns-compare \
	  octodns-dump \
	  octodns-report \
	  octodns-sync \
	  octodns-validate
	docker run -it --rm $(IMAGE) \
	  octodns-sync --help

publish: build
	docker push $(IMAGE)
