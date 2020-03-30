#!/usr/bin/env bash

set -e

PREFIX="test-2."
while true; do
    #clear

    echo ""
    # Add a random metric
    TIMESTAMP=$(date +%s)
    VALUE=$((1 + RANDOM % 20))
    VALUE_2=$((1 + RANDOM % 5))
    METRIC_1="{\"metric\": \"${PREFIX}value\", \"timestamp\": ${TIMESTAMP}, \"value\": ${VALUE}, \"tags\": { \"a\": \"a\", \"b\": \"bb\" } } "
    METRIC_2="{\"metric\": \"${PREFIX}other\", \"timestamp\": ${TIMESTAMP}, \"value\": ${VALUE_2}, \"tags\": { \"a\": \"a\", \"b\": \"bb\" } } "
    METRIC_3="{\"metric\": \"${PREFIX}zero\", \"timestamp\": ${TIMESTAMP}, \"value\": 0, \"tags\":  { \"c\": \"c\"  } } "
    METRICS="[${METRIC_1}, ${METRIC_2}, ${METRIC_3}]"
    echo "INFO: Sending ${METRICS}"
    curl -i \
        -X POST --data "${METRICS}" "http://127.0.0.1:4242/api/put?details"

    #
    echo ""
    echo "INFO: Sleeping"
    sleep $[ ( $RANDOM % 2 )  + 1 ]s
done
