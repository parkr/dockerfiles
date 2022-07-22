#!/bin/bash

if [ -n "$DEBUG" ]; then set -x; fi

set -e

current_dir="$( cd "$(dirname "$0")" ; pwd -P )"
version_file_path="${current_dir}/VERSION"
echo "$version_file_path"

# 'rclone vx.y.z'
curl --silent https://api.github.com/repos/fetzu/teslamate-abrp/commits/main | jq -r .sha > "$version_file_path"

cat "$version_file_path"
