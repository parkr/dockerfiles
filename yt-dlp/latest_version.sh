#!/bin/bash

if [ -n "$DEBUG" ]; then set -x; fi

set -e

current_dir="$( cd "$(dirname "$0")" ; pwd -P )"
version_file_path="${current_dir}/VERSION"
echo "$version_file_path"

curl --silent --fail https://api.github.com/repos/yt-dlp/yt-dlp/releases/latest | jq -r .tag_name > "$version_file_path"

[ -s "$version_file_path" ] || ( echo "empty latest version"; exit 1 )

cat "$version_file_path"
