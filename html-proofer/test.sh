#!/bin/bash

set -ex

TAG="$1"
test -z "$1" && {
    echo "usage: $0 <FULL_TAG>"
    exit 1
}

docker run $TAG
