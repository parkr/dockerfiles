#!/bin/sh

if netstat -l -t -n -p | grep ':::8080'; then
    echo "Running"
    exit 0
else
    echo "Not listening on :8080"
    exit 1
fi
