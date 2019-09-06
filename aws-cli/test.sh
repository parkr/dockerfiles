#!/bin/bash

TAG="$1"
test -z "$1" && {
    echo "usage: $0 <FULL_TAG>"
    exit 1
}

cleanup() {
  test -f output.txt && rm output.txt
}
trap cleanup EXIT

docker run --rm "$TAG" ecr help >output.txt 2>&1
cat output.txt
grep 'Amazon Elastic Container Registry' output.txt
