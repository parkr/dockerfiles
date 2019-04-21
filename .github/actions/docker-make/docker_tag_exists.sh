#!/bin/sh

set -eu

if [ $# -eq 0 ]; then
  echo "usage: $0 <project> -- <command>"
  exit 1
fi

PROJECT_NAME="$1"
VERSION=$(cat "$PROJECT_NAME"/VERSION)
shift

which curl
which jq

function docker_tag_exists() {
    EXISTS=$(curl -s https://hub.docker.com/v2/repositories/$1/tags/?page_size=10000 | jq -r "[.results | .[] | .name == \"$2\"] | any")
    test $EXISTS = true
}

function run_command() {
  if [ "$1" == "--" ]; then
    shift
  fi
  exec sh -c "$*"
}

if [ "${VERSION}" = "latest" ]; then
  run_command "$@"
  exit $?
fi

if docker_tag_exists "parkr/${PROJECT_NAME}" "${VERSION}"; then
    echo "parkr/${PROJECT_NAME}:${VERSION}" exists on Docker Hub.
    # Normally, we would exit 78 and the GitHub Actions UI would show that
    # this is "declined" and the other targets would build. Unfortunately,
    # due to a limitation in GitHub Actions, parallel builds are still
    # canceled when this one is canceled, so we return a happy code instead
    # to know that we've satisfied the request of the Action.
    # exit 78
    exit 0
else
  echo "parkr/${PROJECT_NAME}:${VERSION}" does not exist on Docker Hub.
fi

run_command "$@"
exit $?
