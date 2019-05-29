#!/bin/sh -lu

DOCKER_REGISTRY_URL="docker.pkg.github.com"
echo "Logging into $DOCKER_REGISTRY_URL..."
echo "$GPR_PASSWORD" | docker login -u "$GPR_USERNAME" --password-stdin "$DOCKER_REGISTRY_URL"
