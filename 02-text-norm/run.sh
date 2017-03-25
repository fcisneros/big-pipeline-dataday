#!/bin/bash

function usage() {
cat <<EOF

Extracts and normalize the content of commoncrawl's warc files given by the input pattern (warc.wet)
The specific configuration details can be overriden with the following env variables:
INPUT             (required) input pattern, for example /wet/*.warc.wet.gz
OUTPUT            (optional) output base path, default /pagerank

Usage: $0

EOF

exit 1
}

hash pig 2>/dev/null || { echo >&2 ">>> pig binary is not installed or is not on your PATH env. Aborting."; exit 1; }
[ -z "$INPUT" ] && echo "Need to set INPUT variable" && usage ;

OUTPUT=${OUTPUT:='/textnorm'}

echo "Running Text Normalization with input=${INPUT} :: output=${OUTPUT}"
pig -f normalize.pig -param INPUT="${INPUT}" -param OUTPUT="${OUTPUT}"

# Output error logs, if any
if ls pig_* 1> /dev/null 2>&1; then
    >&2 echo "Error logs found"
    cat pig_* >&2
fi
