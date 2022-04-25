#!/bin/bash

if [ -n "$DEBUG" ]; then set -x; fi

set -e

current_dir="$( cd "$(dirname "$0")" ; pwd -P )"
package_name="$(basename "${current_dir}")"
trap "rm -f output-${package_name}.json" EXIT

curl \
  --silent \
  "https://registry.npmjs.org/${package_name}" > "output-${package_name}.json"
(jq -r '."dist-tags".latest' "output-${package_name}.json" > "${current_dir}/VERSION") || {
    cat "output-${package_name}.json"
    echo "FAILURE"
    exit 1
}
