#!/bin/bash

if ps auxw | grep [a]irupnp-x86-64; then
    echo "Working."
    exit 0
else
    echo "Crashed."
    exit 1
fi
