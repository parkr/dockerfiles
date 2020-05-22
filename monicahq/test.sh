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

set -ex

docker run --rm --entrypoint=/bin/sh "$TAG" -c "env"
docker run --rm --entrypoint=/bin/sh "$TAG" -c "grep /var/www/monica /etc/periodic/hourly/monica"
docker run --rm --entrypoint=/bin/sh "$TAG" -c "which httpd"
docker run --rm --entrypoint=/bin/sh "$TAG" -c "which entrypoint.sh"
docker run --rm --entrypoint=/bin/sh "$TAG" -c "which apache2-foreground"
