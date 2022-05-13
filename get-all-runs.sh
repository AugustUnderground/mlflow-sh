#!/bin/sh

EXP_ID=""

HOST="localhost"
PORT="6008"

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

printf "Downloading all runs of Experiment $EXP_ID\n"

RUNS=$(./get-runs.sh -h "$HOST" -p "$PORT" -e "$EXP_ID")

mkdir -pv "./metrics/$EXP_ID"

for RUN in $RUNS; do
    printf "\tDownloading $RUN from $EXP_ID ..."
    ./get-all-metrics.sh -h "$HOST" -p "$PORT" -r "$RUN"
    printf "\e[1;32m 🗸\e[0m\n"
    mv -v "./$RUN" "./metrics/$EXP_ID/"
done
