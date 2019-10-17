#!/bin/sh -lu

DOCKER_REGISTRY_URL="docker.pkg.github.com"
echo "Logging into $DOCKER_REGISTRY_URL..."
echo "$GITHUB_TOKEN" | docker login -u "$GPR_USERNAME" --password-stdin "$DOCKER_REGISTRY_URL"
