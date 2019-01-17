#!/bin/bash

set -ex

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

TEST_URL="https://api.github.com/users/defunkt"

# Test 1: does it build?
echo -e "FROM $TAG\nRUN curl $TEST_URL" | docker build -t parkr-curl-test -f - .

# Test 2: does it run?
docker run --rm "$TAG" https://api.github.com/users/defunkt