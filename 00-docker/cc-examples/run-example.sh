#!/bin/bash

JAR="/app/cc-warc-examples.jar"

function usage() {
cat <<EOF

Run one of the CommonCrawl examples (https://github.com/fcisneros/cc-warc-examples) jobs.

Usage: $0 [exampleName] inputPath outputPath

exampleName values:
wc            WETWordCount example
st            WATServerType example

inputPath:    The example inputPath (ie file:///data/*warc.wet.gz)
outputPath:   The example local outputPath (ie /data/output)


EOF
exit 1
}

inputPath="${2}"
outputPath="${3}"

if [[ $1 == "wc" ]]; then
  hadoop jar $JAR org.commoncrawl.examples.mapreduce.WETWordCount -Dinput=$inputPath -Doutput=$outputPath

  exit 0
fi

if [[ $1 == "st" ]]; then
  hadoop jar $JAR org.commoncrawl.examples.mapreduce.WATServerType -Dinput=$inputPath -Doutput=$outputPath

  exit 0
fi

usage()
