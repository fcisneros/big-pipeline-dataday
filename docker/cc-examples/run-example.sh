#!/bin/bash
# This script must be executed inside a dataday/hadoop-client container
# It is assumed that the working dir is set during start up and the
# necessary volumes are mounted

DATADIR="/app/data"
JAR="/app/cc-warc-examples.jar"

export PATH="/opt/hadoop/bin:${PATH}"

function usage() {
cat <<EOF

Run one of the CommonCrawl examples (https://github.com/fcisneros/cc-warc-examples) jobs.

Usage: $0 [example]

examples:
wc        WETWordCount example
st        WATServerType example

EOF
exit 1
}

if [[ $1 == "wc" ]]; then
  inputPath="file://${DATADIR}/*.warc.wet.gz"
  #inputPath="s3://commoncrawl/crawl-data/CC-MAIN-2013-48/segments/1386163035819/wet/CC-MAIN-20131204131715-00000-ip-10-33-133-15.ec2.internal.warc.wet.gz"
  #inputPath="s3://commoncrawl/crawl-data/CC-MAIN-2013-48/segments/1386163035819/wet/*.warc.wet.gz"
  outputPath="${DATADIR}/wet-wordcount"

  hadoop jar $JAR org.commoncrawl.examples.mapreduce.WETWordCount -Dinput=$inputPath -Doutput=$outputPath && \
  mkdir -p $outputPath && rm -f $outputPath/part* && \
  hadoop fs -get $outputPath/part* $outputPath

  exit 0
fi

if [[ $1 == "st" ]]; then
  inputPath="file://${DATADIR}/*.warc.wat.gz"
  #inputPath="s3://commoncrawl/crawl-data/CC-MAIN-2013-48/segments/1386163035819/wet/CC-MAIN-20131204131715-00000-ip-10-33-133-15.ec2.internal.warc.wet.gz"
	#inputPath="s3://commoncrawl/crawl-data/CC-MAIN-2013-48/segments/1386163035819/wet/*.warc.wet.gz"
  outputPath="${DATADIR}/wat-servertype"

  hadoop jar $JAR org.commoncrawl.examples.mapreduce.WATServerType -Dinput=$inputPath -Doutput=$outputPath && \
  mkdir -p $outputPath && rm -f $outputPath/part* && \
  hadoop fs -get $outputPath/part* $outputPath

  exit 0
fi

usage()
