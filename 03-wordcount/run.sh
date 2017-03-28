#!/bin/bash

function usage() {
cat <<EOF

Tokenizes and runs a wordcount of the given input (in the form (id,text)).
The specific configuration details can be overriden with the following env variables:
INPUT             (required) input pattern, for example /text/part*
OUTPUT            (optional) output base path, default /wordcount

Usage: $0

EOF

exit 1
}

hash pig 2>/dev/null || { echo >&2 ">>> pig binary is not installed or is not on your PATH env. Aborting."; exit 1; }
[ -z "$INPUT" ] && echo "Need to set INPUT variable" && usage ;

OUTPUT=${OUTPUT:='/textnorm'}

echo "Running Wordcount with input=${INPUT} :: output=${OUTPUT}"
pig -f wordcount.pig -param INPUT="${INPUT}" -param OUTPUT="${OUTPUT}"

# Output error logs, if any
if ls pig_* 1> /dev/null 2>&1; then
    >&2 echo "Error logs found"
    cat pig_* >&2
fi
