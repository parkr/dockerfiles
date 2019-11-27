#!/bin/sh

set -ex
test -n "$(dig @127.0.0.1 -p $TUNNEL_DNS_PORT +short github.com)"
