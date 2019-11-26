#!/bin/bash

set -e

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

cleanup_docker_container() {
    docker stop $container_id
    docker rm $container_id
}

cloudflared_port=5053
docker_opts="--publish $cloudflared_port:$cloudflared_port/udp"
docker_opts="$docker_opts --env TUNNEL_DNS_ADDRESS=0.0.0.0"
docker_opts="$docker_opts --env TUNNEL_DNS_PORT=$cloudflared_port"
docker_opts="$docker_opts --env TUNNEL_DNS_UPSTREAM=https://1.1.1.1/dns-query,https://1.0.0.1/dns-query"
docker_opts="$docker_opts --health-cmd /bin/healthcheck_dns_proxy.sh"
docker_opts="$docker_opts --detach"
set -x
container_id=$(docker run ${docker_opts[@]} "$TAG" proxy-dns)
set +x
trap cleanup_docker_container exit

if docker ps -a -q | grep "${container_id:0:12}"; then
    echo "cloudflared is running..."
else
    echo "cloudflared is not running..."
    docker logs $container_id
    exit 1
fi

sleep 3

set -x

docker logs $container_id

dig @127.0.0.1 -p "$cloudflared_port" +short github.com
