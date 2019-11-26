#!/bin/sh

set -ex
dig @127.0.0.1 -p $CLOUDFLARED_PORT +short github.com
