

SCRIPTS_FOLDER=./install

install_go: ## Install development env
	@bash ${SCRIPTS_FOLDER}/deps/install_go

install_go_deps: ## Get the dependencies
	@go get -v -d ./...


