#!/bin/bash

if [ -n "$DEBUG" ]; then set -x; fi

set -e

trap "rm -f output" EXIT
current_dir="$( cd "$(dirname "$0")" ; pwd -P )"

curl \
  --silent \
  https://hub.docker.com/v2/repositories/library/monica/tags?page_size=100 > output
(jq -r .results[].name output | grep \\-apache | head -n 1 | cut -d- -f1 > "${current_dir}/VERSION") || {
    cat output
    echo "FAILURE"
    exit 1
}
