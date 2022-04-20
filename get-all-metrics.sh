#!/bin/sh

RUN_ID=""

HOST="localhost"
PORT="6008"

while getopts "r:h:p:" opt; do
    case "$opt" in
        r ) RUN_ID=$OPTARG
            ;;
        h ) HOST=$OPTARG
            ;;
        p ) PORT=$OPTARG
            ;;
    esac
done

shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift

METRICS=$(./get-metrics.sh -h "$HOST" -p "$PORT" -r "$RUN_ID")

for METRIC in $METRICS; do
    mkdir -p "./$RUN_ID"
    ./get-metric.sh -h "$HOST" -p "$PORT" -r "$RUN_ID" -m "$METRIC" -f "./$RUN_ID/$METRIC.csv"
done
