#!/bin/sh
#/ Usage: entrypoint.sh [login|logout]
#/ Default usage is to login.
#/ Logs in or out of a given Docker registry.

subcommand="$1"
if [ -z "$subcommand" ]; then
    subcommand=login
fi
echo "Attempting $subcommand..."

require_env_vars() {
    for var in "$@"; do
        if [ -z "${!var}" ]; then
            echo "The '${var}' env var is required"
            exit 1
        fi
    done
}

case "$subcommand" in
login*)
    require_env_vars DOCKER_REGISTRY_URL DOCKER_USERNAME DOCKER_PASSWORD
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin "$DOCKER_REGISTRY_URL"
    ;;
logout*)
    docker logout "$DOCKER_REGISTRY_URL"
    ;;
esac
