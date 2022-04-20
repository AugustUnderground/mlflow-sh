#!/bin/sh

RUN_ID=""

HOST="localhost"
PORT="6008"

GET_RUN="api/2.0/mlflow/runs/get"

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

URL="http://$HOST:$PORT/$GET_RUN?run_id=$RUN_ID"
CMD=".run.data.metrics[] | [.key] | add"

curl -s -X GET "$URL" | jq -r "$CMD"
