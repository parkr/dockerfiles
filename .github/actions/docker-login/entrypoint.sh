#!/bin/sh

if [ -z "$DOCKER_REGISTRY_URL" ]; then
    echo "The 'DOCKER_REGISTRY_URL' env var is required"
    exit 1
fi

if [ -z "$DOCKER_USERNAME" ]; then
    echo "The 'DOCKER_USERNAME' env var is required"
    exit 1
fi

if [ -z "$DOCKER_PASSWORD" ]; then
    echo "The 'DOCKER_PASSWORD' env var is required"
    exit 1
fi

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin "$DOCKER_REGISTRY_URL"
