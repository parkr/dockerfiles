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
  --name test_kill_the_newsletter_1 \
  --env WEB_PORT=8080 \
  --env BASE_URL=http://localhost:8080 \
  --publish 8080:8080 \
  "$TAG" &
cleanup() {
  docker stop test_kill_the_newsletter_1
}
trap cleanup exit
sleep 5
curl --fail http://localhost:8080
