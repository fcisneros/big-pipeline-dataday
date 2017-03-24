#!/bin/bash

function usage() {
cat <<EOF

Runs a PageRank over a commoncrawl's warc files given by the input pattern (warc.wat)
The specific configuration details can be overriden with the following env variables:
INPUT             (required) input pattern, for example /wat/*.warc.wat.gz
OUTPUT            (optional) output base path, default /pagerank
DAMPING_FACTOR    (optional) pagerank's damping factor, default 0.75
ITER_NUM          (optional) number of iterations, default 10

Usage: $0

EOF

exit 1
}

hash pig 2>/dev/null || { echo >&2 ">>> pig binary is not installed or is not on your PATH env. Aborting."; exit 1; }
[ -z "$INPUT" ] && echo "Need to set INPUT variable" && usage ;

OUTPUT=${OUTPUT:='/pagerank'}
DAMPING_FACTOR=${DAMPING_FACTOR:='0.75'}
ITER_NUM=${ITER_NUM:=10}

echo "Running PageRank with input=${INPUT} :: output=${OUTPUT} :: damping=${DAMPING_FACTOR} :: iterations=${ITER_NUM}"
#pig -f links.pig -param INPUT="${INPUT}" -param OUTPUT="${OUTPUT}/links" && \
pig pagerank.py "${OUTPUT}/links" "${OUTPUT}" "${DAMPING_FACTOR}" "${ITER_NUM}"

# Output error logs, if any
if ls pig_* 1> /dev/null 2>&1; then
    >&2 echo "Error logs found"
    cat pig_* >&2
fi
