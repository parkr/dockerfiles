#!/bin/sh
set -e

# Prepend "curl" to the arguments if the first argument is not an executable.
if ! type -- "$1" &> /dev/null; then
	set -- curl "$@"
fi

exec "$@"