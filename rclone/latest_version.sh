#!/bin/bash

if [ -n "$DEBUG" ]; then set -x; fi

set -e

current_dir="$( cd "$(dirname "$0")" ; pwd -P )"
version_file_path="${current_dir}/VERSION"
echo "$version_file_path"

# 'rclone vx.y.z'
curl --silent https://downloads.rclone.org/version.txt | awk '{print $2}' > "$version_file_path"

cat "$version_file_path"
