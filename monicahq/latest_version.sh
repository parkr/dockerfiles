#!/bin/bash

if [ -n "$DEBUG" ]; then set -x; fi

set -e

trap "rm -f output" EXIT
current_dir="$( cd "$(dirname "$0")" ; pwd -P )"

payload='{"uuid":"B007FF6D-C2DC-41B0-9B7D-680D5761CE8A","contacts":1,"version":"1.0.0"}'
curl -X POST \
  --silent \
  -H "Content-Type: application/json" \
  -d "$payload" \
  https://version.monicahq.com/ping > output
(jq -r .latest_version output > "${current_dir}/VERSION") || {
    cat output
    echo "FAILURE"
    exit 1
}
