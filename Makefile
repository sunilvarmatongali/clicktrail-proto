.DEFAULT_GOAL := help

.PHONY: help
help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-12s %s\n", $$1, $$2}'

.PHONY: lint
lint: ## Check the .proto files follow the style rules
	buf lint

.PHONY: generate
generate: ## Regenerate the Go code from the .proto files
	buf generate

.PHONY: build
build: ## Make sure the generated Go code compiles
	go build ./...

.PHONY: verify
verify: lint generate build ## Run every check (use before opening a pull request)
	git diff --exit-code -- gen
