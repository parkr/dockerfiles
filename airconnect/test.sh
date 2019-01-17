#!/bin/bash

if [ -L "$0" ]; then
    root=$(cd "$(dirname "$(readlink "$0")")" && pwd)
else
    root=$(cd "$(dirname "$0")" && pwd)
fi

TAG="$1"
test -z "$1" && {
    echo "usage: $0 <TAG>"
    exit 1
}

CONFIG_FILE="$root/config.xml"

set -x
docker run \
    -v "$CONFIG_FILE:$CONFIG_FILE" \
    --rm \
    --net=host \
    $TAG \
    -m squeezebox -l 1000:2000 -Z -f /dev/stdout -x "$CONFIG_FILE"