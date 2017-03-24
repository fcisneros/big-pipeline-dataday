EXECUTABLES = docker docker-compose aws
K := $(foreach exec,$(EXECUTABLES),\
	$(if $(shell which $(exec)),some string,$(error "No $(exec) found in PATH")))

.PHONY: data


build:
	$(MAKE) --directory=00-docker build
	$(MAKE) images

images:
	@docker images | grep dataday

clean:
	@echo "Removing stopped containers"
	@docker rm $(docker ps -a -q)
	@echo "Removing dangling images"
	@docker rmi $(docker images --quiet --filter "dangling=true")

data:
	@echo "Downloading sample data"
	mkdir -p data/
	@aws s3 --no-sign-request cp s3://commoncrawl/crawl-data/CC-MAIN-2013-48/segments/1386163035819/wet/CC-MAIN-20131204131715-00000-ip-10-33-133-15.ec2.internal.warc.wet.gz data/
	@aws s3 --no-sign-request cp s3://commoncrawl/crawl-data/CC-MAIN-2013-48/segments/1386163035819/wat/CC-MAIN-20131204131715-00000-ip-10-33-133-15.ec2.internal.warc.wat.gz data/