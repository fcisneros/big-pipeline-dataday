EXECUTABLES = docker docker-compose aws
K := $(foreach exec,$(EXECUTABLES),\
	$(if $(shell which $(exec)),some string,$(error "No $(exec) found in PATH")))

.PHONY: build


build:
	$(MAKE) --directory=00-docker build
	$(MAKE) images

images:
	@docker images | grep dataday

clean: stop
	@echo "Cleaning all resources"
	@docker-compose down
	@sleep 15
	@docker rm $(shell docker ps -a -q)
	@docker rmi $(shell docker images --quiet --filter "dangling=true")
	@sudo rm -rf output/*
	@rm -f .copied

data:
	@echo "Downloading sample data"
	mkdir -p data/
	@aws s3 --no-sign-request cp s3://commoncrawl/crawl-data/CC-MAIN-2013-48/segments/1386163035819/wet/CC-MAIN-20131204131715-00000-ip-10-33-133-15.ec2.internal.warc.wet.gz data/
	@aws s3 --no-sign-request cp s3://commoncrawl/crawl-data/CC-MAIN-2013-48/segments/1386163035819/wat/CC-MAIN-20131204131715-00000-ip-10-33-133-15.ec2.internal.warc.wat.gz data/

.started:
	@docker-compose up -d hadoop-master
	@sleep 30
	@touch .started

start: .started # Starts local hadoop cluster
	@docker-compose ps

stop:
	@docker-compose stop
	rm -f .started

copy: .copied
	@echo "Copying sample data to hdfs..."

.copied:
	@docker-compose run data2hdfs
	@touch .copied


client:
	@echo "Starting client terminal"
	@docker-compose run --rm client


# Bad practice: orchestration missing!
pagerank: start
	@docker-compose build
	@docker-compose up pagerank-pig

textnorm: start
	@docker-compose build
	@docker-compose up textnorm-pig

wordcount: start
	@docker-compose build
	@docker-compose up wordcount-pig
