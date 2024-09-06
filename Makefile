BOLD := \033[1m
RESET := \033[0m
GREEN := \033[1;32m

# -- Docker
DOCKER_UID           = $(shell id -u)
DOCKER_GID           = $(shell id -g)
DOCKER_USER          = $(DOCKER_UID):$(DOCKER_GID)

# ==============================================================================
# RULES

default: h

build: ## Build peertube-runner image
	docker buildx build --build-arg DOCKER_USER=$(DOCKER_USER) --target runner -t peertube-runner:latest .
.PHONY:build

build-whisper_ctranslate2: ## Build peertube-runner image with whisper-ctranslate2
	docker buildx build --build-arg DOCKER_USER=$(DOCKER_USER) --target whisper_ctranslate2 -t peertube-runner:latest-whisper_ctranslate2 .
.PHONY:build-whisper_ctranslate2

h: # short default help task
	@echo "$(BOLD)Marsha Makefile$(RESET)"
	@echo "Please use 'make $(BOLD)target$(RESET)' where $(BOLD)target$(RESET) is one of:"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(GREEN)%-50s$(RESET) %s\n", $$1, $$2}'
.PHONY: h

help:  ## Show a more readable help on multiple lines
	@echo "$(BOLD)Marsha Makefile$(RESET)"
	@echo "Please use 'make $(BOLD)target$(RESET)' where $(BOLD)target$(RESET) is one of:"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(GREEN)%s$(RESET)\n    %s\n\n", $$1, $$2}'
.PHONY: help