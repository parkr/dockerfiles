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

# Help text
docker run --rm "$TAG" -h

# Does it have our network tools?
docker run --rm "$TAG" -ignore-exit-code 1 curl -h
docker run --rm "$TAG" wget -h
