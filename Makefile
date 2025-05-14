ifeq (, $(shell which docker))
    $(error "Docker is not installed!")
endif

.SHELLFLAGS = -ec
.DEFAULT_GOAL := help

PUSH ?= false
VERSION ?= latest


DOCKER_BUILD_ARGS =
ifeq ($(PUSH), true)
    DOCKER_BUILD_ARGS += --push
endif

VARIABLES = version=$(VERSION)

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  docker-build:     Build the Docker images"
	@echo "  help:             Show this help message"


.PHONY: docker-build
docker-build:
	$(VARIABLES) docker buildx bake $(DOCKER_BUILD_ARGS) all