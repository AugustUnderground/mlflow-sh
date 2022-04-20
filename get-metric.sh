#!/bin/sh

METRIC=""
RUN_ID=""

HOST="localhost"
PORT="6008"

CSV_FILE="./metric.csv"

GET_METRIC="api/2.0/mlflow/metrics/get-history"

while getopts "m:r:h:p:f:" opt; do
    case "$opt" in
        m ) METRIC=$OPTARG
            ;;
        r ) RUN_ID=$OPTARG
            ;;
        h ) HOST=$OPTARG
            ;;
        p ) PORT=$OPTARG
            ;;
        f ) CSV_FILE=$OPTARG
            ;;
    esac
done

shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift

URL="http://$HOST:$PORT/$GET_METRIC?run_id=$RUN_ID&metric_key=$METRIC"
CMD="[\"TimeStamp\", \"Step\", \"$METRIC\"] , (.metrics[] | [.timestamp, .step, .value]) | @csv"

curl -s -X GET "$URL" | jq -r "$CMD" > $CSV_FILE
