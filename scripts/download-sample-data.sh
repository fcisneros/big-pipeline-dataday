#!/bin/bash

CURDIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
cd ${CURDIR}/../

hash aws 2>/dev/null || { echo >&2 ">>> aws cli is not installed or is not on your PATH env. Aborting."; exit 1; }

#aws s3 --no-sign-request cp s3://commoncrawl/crawl-data/CC-MAIN-2013-48/segments/1386163035819/warc/CC-MAIN-20131204131715-00000-ip-10-33-133-15.ec2.internal.warc.gz data/
aws s3 --no-sign-request cp s3://commoncrawl/crawl-data/CC-MAIN-2013-48/segments/1386163035819/wet/CC-MAIN-20131204131715-00000-ip-10-33-133-15.ec2.internal.warc.wet.gz data/
aws s3 --no-sign-request cp s3://commoncrawl/crawl-data/CC-MAIN-2013-48/segments/1386163035819/wat/CC-MAIN-20131204131715-00000-ip-10-33-133-15.ec2.internal.warc.wat.gz data/
