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

VALID_SCHEMA="${root}/fixture-valid.graphql"
INVALID_SCHEMA="${root}/fixture-invalid.graphql"

set -x

# Does it know a valid schema?
docker run --rm -i "$TAG" --stdin < "$VALID_SCHEMA"
if [ $? -ne 0 ]; then
    echo "Expected clean exit."
    exit 1
fi

# Does it know an invalid schema?
docker run --rm -i "$TAG" --stdin < "$INVALID_SCHEMA"
if [ $? -ne 1 ]; then
    echo "Expected errors."
    exit 1
fi