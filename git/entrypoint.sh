#!/bin/sh
set -e

# Prepend "git" to the arguments if the first argument is not an executable.
if ! type -- "$1" &> /dev/null; then
	set -- git "$@"
fi

exec "$@"
