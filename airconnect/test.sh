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

set -x
docker run --rm --entrypoint=/bin/sh "$TAG" -c "which airupnp-linux-x86_64"
docker run --rm --entrypoint=/bin/sh "$TAG" -c "which airupnp-linux-x86_64-static"
