#!/bin/bash

CURDIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
cd ${CURDIR}/../docker

hash docker 2>/dev/null || { echo >&2 ">>> docker is not installed or is not on your PATH env. Aborting."; exit 1; }

docker build -t dataday/hadoop-master ./hadoop-master
docker build -t dataday/hadoop-client ./hadoop-client
docker build -t dataday/pig-client ./pig-client
docker build -t dataday/cc-examples ./cc-examples

docker images | grep dataday