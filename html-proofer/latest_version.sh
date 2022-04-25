#!/bin/bash

if [ -n "$DEBUG" ]; then set -x; fi

set -e

current_dir="$( cd "$(dirname "$0")" ; pwd -P )"
gem_name="$(basename "${current_dir}")"
output_filename="output-${gem_name}.json"
trap "rm -f ${output_filename}" EXIT

curl --silent --fail "https://api.rubygems.org/api/v1/gems/${gem_name}.json" > "${output_filename}"
(jq -r .version "${output_filename}" > "${current_dir}/VERSION") || {
    cat "${output_filename}"
    echo "FAILURE"
    exit 1
}
