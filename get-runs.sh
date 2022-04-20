#!/bin/sh

EXP_ID=""

HOST="localhost"
PORT="6008"

GET_RUNS="api/2.0/mlflow/runs/search"

while getopts "e:h:p:" opt; do
    case "$opt" in
        e ) EXP_ID=$OPTARG
            ;;
        h ) HOST=$OPTARG
            ;;
        p ) PORT=$OPTARG
            ;;
    esac
done

shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift

DATA='{"experiment_ids": ["165"]}'
HEAD="Content-Type: application/json"

URL="http://$HOST:$PORT/$GET_RUNS"
CMD=".runs[] | [.info] | add | .run_id"

curl -s -d "$DATA" -H "$HEAD" -X POST "$URL" | jq -r "$CMD"
