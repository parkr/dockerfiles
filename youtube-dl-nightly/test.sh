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
docker run --rm -v "$(pwd)":/youtube-dl "$TAG" "https://soundcloud.com/royalty-free-music-track/this-8-bit-game-music-royalty"
