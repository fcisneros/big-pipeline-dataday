#!/bin/bash

function usage() {
cat <<EOF

Runs a PageRank over a commoncrawl's warc files given by the input pattern (warc.wat)

Usage: $0 inputPattern outputPath [dampingFactor]

EOF
}

hash pig 2>/dev/null || { echo >&2 ">>> pig binary is not installed or is not on your PATH env. Aborting."; exit 1; }

if [ "$#" -ne 2 ] || ! [ -d "$2" ]; then
  usage
  exit 1
fi


inputPattern="$1"
outputPath="$2"
damping=$3


echo "Running PageRank with input=${inputPattern} :: output=${outputPath}"
pig -f links.pig -param INPUT="${inputPattern}" -param OUTPUT="${outputPath}/links" && \
pig -f pagerank.py -param INPUT="${outputPath}/links" -param OUTPATH="${outputPath}" -param DAMPING=${damping:=0.75}

# Output error logs, if any
if ls pig_* 1> /dev/null 2>&1; then
    >&2 echo "Error logs found"
    cat pig_* >&2
fi
