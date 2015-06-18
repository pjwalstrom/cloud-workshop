#!/usr/bin/env bash

set -e

echo ""
echo "Starting helper containers..."

docker_if=$(ip route | awk '/docker0/ {print $9}')

docker rm -f consul || true
docker run --name consul -d -h $HOSTNAME -v /data \
    -p $docker_if:8400:8400 -p 0.0.0.0:8500:8500 \
    progrium/consul -server -advertise $docker_if -bootstrap -ui-dir /ui

docker rm -f registrator || true
docker run --name registrator -d -h vagrant \
    -v /var/run/docker.sock:/tmp/docker.sock \
    stigkj/registrator:v5.1 -ip $docker_if consul://$docker_if:8500

# Must remove symbolic link created by the container from an eventual earlier run
sudo rm -f /tmp/haproxy.tmpl
cp -f /vagrant/helpers/consul.tmpl /tmp/
docker rm -f haproxy || true
docker run --name haproxy --net=host -d \
    -v /tmp:/consul-template/template.d \
    -e CONSUL_CONNECT=$docker_if:8500 \
    asteris/haproxy-consul
