#!/bin/bash

# 'rclone vx.y.z'
curl https://downloads.rclone.org/version.txt | awk '{print $2}' > VERSION
