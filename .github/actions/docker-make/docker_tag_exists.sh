#!/bin/sh

set -eu

PROJECT_NAME="$1"
VERSION=$(cat "$PROJECT_NAME"/VERSION)
shift

function docker_tag_exists() {
    EXISTS=$(curl -s https://hub.docker.com/v2/repositories/$1/tags/?page_size=10000 | jq -r "[.results | .[] | .name == \"$2\"] | any")
    test $EXISTS = true
}

if docker_tag_exists "parkr/${PROJECT_NAME}" "${VERSION}"; then
    echo "parkr/${PROJECT_NAME}:${VERSION}" exists on Docker Hub.
    exit 78
else
    echo "parkr/${PROJECT_NAME}:${VERSION}" does not exist on Docker Hub.
    if [ "$1" == "--" ]; then
        shift
        exec sh -c "$*"
    fi
    exit 0
fi