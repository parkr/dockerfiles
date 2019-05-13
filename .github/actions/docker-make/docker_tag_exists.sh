#!/bin/sh

set -xu

if [ $# -eq 0 ]; then
  echo "usage: $0 <project> -- <command>"
  exit 1
fi

: ${DOCKER_REGISTRY_URL:=""}
PROJECT_NAME="$1"
REPO="${PROJECT_NAME}"
VERSION=$(cat "${PROJECT_NAME##*/}"/VERSION)
shift

command -v curl
command -v jq

docker_registry_url() {
  local repo="$1"
  case $repo in
    docker.pkg.github.com*)
      echo "https://docker.pkg.github.com/v2/repositories/${repo/docker.pkg.github.com\//}"
      ;;
    *)
      echo "https://hub.docker.com/v2/repositories/${repo}"
      ;;
  esac
}

docker_tag_exists() {
    local repo="$1"
    local version="$2"
    EXISTS=$(curl -s "$(docker_registry_url "$repo")/tags/?page_size=10000" | jq -r "[.results | .[] | .name == \"$version\"] | any")
    test "$EXISTS" = true
}

run_command() {
  if [ $# -gt 0 ]; then
    if [ "$1" = "--" ]; then
      shift
    fi
    exec sh -c "$*"
  fi
}

if [ "${VERSION}" = "latest" ]; then
  run_command "$@"
  exit $?
fi

if docker_tag_exists "${REPO}" "${VERSION}"; then
    echo "${REPO}:${VERSION}" exists on Docker Hub.
    # Normally, we would exit 78 and the GitHub Actions UI would show that
    # this is "declined" and the other targets would build. Unfortunately,
    # due to a limitation in GitHub Actions, parallel builds are still
    # canceled when this one is canceled, so we return a happy code instead
    # to know that we've satisfied the request of the Action.
    # exit 78
    exit 0
else
  echo "${REPO}:${VERSION}" does not exist on Docker Hub.
fi

run_command "$@"
exit $?
