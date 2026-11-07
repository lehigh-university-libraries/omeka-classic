SHELL := /bin/bash

.PHONY: help init up clean reconcile healthcheck test lint
.SILENT:

-include custom.Makefile

help: ## Show this help message
	echo 'Usage: make [target]'
	echo ''
	echo 'Available targets:'
	awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%s\033[0m\t%s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort | column -t -s $$'\t'

init reconcile: ## Generate or repair declared initialization state
	docker compose run --rm init

up: init ## Start the complete site and wait for health
	docker compose up --remove-orphans --wait --wait-timeout 1200

clean: ## Delete generated local state after confirmation
	@read -r -p 'Delete all Compose volumes? Type DELETE: ' answer; test "$$answer" = DELETE
	docker compose down --remove-orphans --volumes

healthcheck: ## Check Compose and application health
	docker compose ps

test: ## Run template checks
	./scripts/test.sh

lint: ## Lint template files
	./scripts/lint.sh
