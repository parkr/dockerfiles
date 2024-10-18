#!/bin/sh
# Detect the architecture of the system and print it to stdout
# These are used as the standalone binary suffixes for yt-dlp release artifacts.
# https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#release-files
if [ "$(uname -m)" = "x86_64" ]; then
    echo "" # no suffix for x86_64
elif [ "$(uname -m)" = "aarch64" ]; then
    echo "_aarch64"
elif [ "$(uname -m)" = "arm64" ]; then
    echo "_aarch64"
elif [ "$(uname -m)" = "armv7l" ]; then
    echo "_armv7l"
else
    echo "" # unknown architecture, fall back to x86_64
fi
