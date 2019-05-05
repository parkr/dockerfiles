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

TEST_URL="https://github.com/parkr/test-site.git"

set -ex

# Test 1: does it build?
echo -e "FROM $TAG\nRUN git clone $TEST_URL" | docker build -t parkr-git-test -f - .

# Test 2: what version is it using?
docker run --rm "$TAG" --version

# Test 3: can it clone?
docker run --rm "$TAG" clone $TEST_URL
