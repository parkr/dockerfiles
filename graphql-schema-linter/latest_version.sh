#!/bin/bash

if [ -n "$DEBUG" ]; then set -x; fi

set -e

current_dir="$( cd "$(dirname "$0")" ; pwd -P )"
package_name="$(basename "${current_dir}")"
output_filename="output-${package_name}.json"
trap "rm -f ${output_filename}" EXIT

curl --silent --fail "https://registry.npmjs.org/${package_name}" > "${output_filename}"
(jq -r '."dist-tags".latest' "${output_filename}" > "${current_dir}/VERSION") || {
    cat "${output_filename}"
    echo "FAILURE"
    exit 1
}
