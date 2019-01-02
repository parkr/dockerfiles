VERSION:=v1.45

TAG:=$(VERSION)
DOCKERFILE:=Dockerfile
IMAGE:=parkr/rclone:$(TAG)
all: build

build:
	docker build -t $(IMAGE) -f $(DOCKERFILE) --build-arg VERSION=$(VERSION) .

test: build
	docker run -it --rm $(IMAGE) -h

publish: build
	docker push $(IMAGE)
