EXECUTABLES = docker docker-compose aws
K := $(foreach exec,$(EXECUTABLES),\
	$(if $(shell which $(exec)),some string,$(error "No $(exec) found in PATH")))

.PHONY: build


build:
	@echo "Building base images"
	@docker build -t dataday/hadoop-master ./hadoop-master
	@docker build -t dataday/hadoop-client ./hadoop-client
	#@docker build -t dataday/cc-examples ./cc-examples
