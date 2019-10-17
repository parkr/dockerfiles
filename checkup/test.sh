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

TEMP_IMAGE_TAG="parkr-checkup-test"
cleanup() {
    docker rmi $TEMP_IMAGE_TAG
}
trap cleanup exit

set -x

# Can't use -v in Actions, so let's build a temporary image.
echo -e "FROM $TAG\nCOPY test-config.json /config.json\n" | docker build -t $TEMP_IMAGE_TAG -f - "$root"
docker run --rm $TEMP_IMAGE_TAG --v -c /config.json
