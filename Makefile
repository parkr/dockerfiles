PROJECTS := $(sort $(dir $(wildcard **/Dockerfile)))

default:
	@echo "Hello there, weary traveler."
	@echo "Looking to build a docker image? You've come to the right place."
	@echo
	@echo "I can build, test, and publish any of the following:"
	@for project in $(PROJECTS); do \
		echo "\t$$project" ; \
	done
	@echo
	@echo "Just run build-%, test-%, or publish-% where '%' is the project name."
	@echo "Leave off the trailing /; that's an artifact of make."
	@echo "Example: 'make build-curl'."

build-%:
	$(eval PROJECT_NAME := $(patsubst build-%,%,$@))
	$(eval VERSION := $(shell cat $(PROJECT_NAME)/VERSION))
	$(eval TAG := parkr/$(PROJECT_NAME):$(VERSION) )
	docker build -t $(TAG) $(PROJECT_NAME)

test-%: build-%
	$(eval PROJECT_NAME := $(patsubst test-%,%,$@))
	$(eval VERSION := $(shell cat $(PROJECT_NAME)/VERSION))
	$(eval TAG := parkr/$(PROJECT_NAME):$(VERSION) )
	bash $(PROJECT_NAME)/test.sh $(TAG)

publish-%: test-%
	$(eval PROJECT_NAME := $(patsubst publish-%,%,$@))
	$(eval VERSION := $(shell cat $(PROJECT_NAME)/VERSION))
	$(eval TAG := parkr/$(PROJECT_NAME):$(VERSION) )
	echo "PROJECT_NAME is $(shell $PROJECT_NAME)"
	docker push $(TAG)