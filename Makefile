PROJECTS := $(sort $(dir $(wildcard **/Dockerfile)))
NAMESPACE := parkr
TAG_PREFIX :=
HADOLINT_CFG := $(shell pwd)/.hadolint.yaml
UPDATABLE_PROJECTS := $(sort $(patsubst %/latest_version.sh,update-%,$(wildcard **/latest_version.sh)))

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

docker-buildx-info:
	docker buildx version
	docker buildx ls

docker-buildx-create: docker-buildx-info
	docker buildx create --use --bootstrap --platform linux/arm64,linux/amd64

dive-%: build-%
	$(eval PROJECT_NAME := $(patsubst dive-%,%,$@))
	$(eval VERSION := $(shell cat $(PROJECT_NAME)/VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(TAG_PREFIX)$(VERSION))
	dive $(TAG)

lint-%:
	$(eval PROJECT_NAME := $(patsubst lint-%,%,$@))
	docker build -t hadolint -f support/hadolint-dockerfile .
	docker run --rm -i hadolint < $(PROJECT_NAME)/Dockerfile

build-%: lint-%
	$(eval PROJECT_NAME := $(patsubst build-%,%,$@))
	$(eval VERSION := $(shell cat $(PROJECT_NAME)/VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(TAG_PREFIX)$(VERSION))
	docker build \
		-t $(TAG) \
		--build-arg VERSION=$(VERSION) \
		$(PROJECT_NAME)

test-%: build-%
	$(eval PROJECT_NAME := $(patsubst test-%,%,$@))
	$(eval VERSION := $(shell cat $(PROJECT_NAME)/VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(TAG_PREFIX)$(VERSION))
	bash $(PROJECT_NAME)/test.sh $(TAG)

publish-%: test-% docker-buildx-info
	$(eval PROJECT_NAME := $(patsubst publish-%,%,$@))
	$(eval VERSION := $(shell cat $(PROJECT_NAME)/VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(TAG_PREFIX)$(VERSION))
	docker buildx build \
		--platform linux/arm64,linux/amd64 \
		--push \
		-t $(TAG) \
		--build-arg VERSION=$(VERSION) \
		$(PROJECT_NAME)

sign-%:
	$(eval PROJECT_NAME := $(patsubst sign-%,%,$@))
	$(eval VERSION := $(shell cat $(PROJECT_NAME)/VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(TAG_PREFIX)$(VERSION))
	cosign sign -key cosign.key $(TAG)

verify-%:
	$(eval PROJECT_NAME := $(patsubst verify-%,%,$@))
	$(eval VERSION := $(shell cat $(PROJECT_NAME)/VERSION))
	$(eval REPO := $(NAMESPACE)/$(PROJECT_NAME))
	$(eval TAG := $(REPO):$(TAG_PREFIX)$(VERSION))
	cosign verify -key cosign.pub $(TAG)

published-%:
	$(eval PROJECT_NAME := $(patsubst published-%,%,$@))
	sh ./.github/actions/docker-make/docker_tag_exists.sh $(NAMESPACE)/$(PROJECT_NAME)

buildaction-%:
	$(eval PROJECT_NAME := $(patsubst buildaction-%,%,$@))
	docker build -t $(PROJECT_NAME):latest ./.github/actions/$(PROJECT_NAME)

update: $(UPDATABLE_PROJECTS)
	echo $(UPDATABLE_PROJECTS)

update-%:
	$(eval PROJECT_NAME := $(patsubst update-%,%,$@))
	bash $(PROJECT_NAME)/latest_version.sh
