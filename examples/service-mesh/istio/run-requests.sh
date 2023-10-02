#!/bin/bash

URL="${1}"
NUM_REQUESTS=${2}

for ((i=1; i<=$NUM_REQUESTS; i++)); do
    curl -s -o /dev/null $URL
    echo "Request $i sent"
done