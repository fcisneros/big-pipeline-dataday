#!/bin/bash

# Runs a pig script and prints out any error log file, if any.

hash pig 2>/dev/null || { echo >&2 ">>> pig binary is not installed or is not on your PATH env. Aborting."; exit 1; }

function usage() {
cat <<EOF

Run one pig script passing the given arguments.

Usage: $0 pigScriptPath [arguments]

EOF
exit 1
}

script=$1
shift

echo "Running pig script: $script"
pig -f $script "$@"

if ls pig_* 1> /dev/null 2>&1; then
    echo "Error logs found"
    cat pig_*
else
    echo "Not error logs found"
fi
