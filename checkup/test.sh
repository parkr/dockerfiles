#!/bin/bash

if [ -L "$0" ]; then
    root=$(cd "$(dirname "$(readlink "$0")")" && pwd)
else
    root=$(cd "$(dirname "$0")" && pwd)
fi

TAG="$1"
test -z "$1" && {
    echo "usage: $0 <FULL_TAG>"
    exit 1
}

set -x

docker run --rm \
    -w /app \
    -v "$root/test-config.json:/app/config.json" \
    "$TAG" \
    --v -c /app/config.json