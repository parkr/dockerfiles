PROJECTS := $(sort $(dir $(wildcard **/Dockerfile)))
NAMESPACE := parkr

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

dive-%: build-%
	$(eval PROJECT_NAME := $(patsubst dive-%,%,$@))
	$(eval VERSION := $(shell cat $(PROJECT_NAME)/VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(VERSION))
	dive $(TAG)

build-%:
	$(eval PROJECT_NAME := $(patsubst build-%,%,$@))
	$(eval VERSION := $(shell cat $(PROJECT_NAME)/VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(VERSION))
	docker build -t $(TAG) --build-arg VERSION=$(VERSION) $(PROJECT_NAME)

test-%: build-%
	$(eval PROJECT_NAME := $(patsubst test-%,%,$@))
	$(eval VERSION := $(shell cat $(PROJECT_NAME)/VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(VERSION))
	bash $(PROJECT_NAME)/test.sh $(TAG)

publish-%: test-%
	$(eval PROJECT_NAME := $(patsubst publish-%,%,$@))
	$(eval VERSION := $(shell cat $(PROJECT_NAME)/VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(VERSION))
	docker push $(TAG)

published-%:
	$(eval PROJECT_NAME := $(patsubst published-%,%,$@))
	sh ./.github/actions/docker-make/docker_tag_exists.sh $(NAMESPACE)/$(PROJECT_NAME)
