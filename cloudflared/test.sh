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
docker_opts="$docker_opts --health-interval 1s --health-start-period 1s --health-timeout 3s"
docker_opts="$docker_opts --detach"
set -x
container_id=$(docker run ${docker_opts[@]} "$TAG" proxy-dns)
set +x
trap cleanup_docker_container exit

counter=0
container_health_status=$(docker inspect $container_id | jq -r .[].State.Health.Status)
while [ "$container_health_status" != "healthy" ] && [ $counter -lt 10 ]; do
    counter=$((counter+1))
    container_health_status=$(docker inspect $container_id | jq -r .[].State.Health.Status)
    echo "Container Health Status: $container_health_status"
    sleep 1
done

docker inspect $container_id | jq .[].State.Health
docker logs $container_id

if [ "$container_health_status" != "healthy" ]; then
    exit 1
fi
