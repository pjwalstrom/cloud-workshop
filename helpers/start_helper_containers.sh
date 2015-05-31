#!/usr/bin/env bash

set -e

echo ""
echo "Starting helper containers..."

docker run --name consul -d -h vagrant -v /data \
    -p 192.168.12.34:8300:8300 \
    -p 192.168.12.34:8301:8301 \
    -p 192.168.12.34:8301:8301/udp \
    -p 192.168.12.34:8302:8302 \
    -p 192.168.12.34:8302:8302/udp \
    -p 192.168.12.34:8400:8400 \
    -p 192.168.12.34:8500:8500 \
    -p 172.17.42.1:53:53/udp \
    progrium/consul -server -advertise 192.168.12.34 -bootstrap -ui-dir /ui

docker run --name registrator -d -h vagrant \
    -v /var/run/docker.sock:/tmp/docker.sock \
    stigkj/registrator:v5.1 -ip 192.168.12.34 consul://192.168.12.34:8500

# Must remove symbolic link created by the container from an eventual earlier run
sudo rm -f /tmp/haproxy.tmpl
cp -f /vagrant/helpers/consul.tmpl /tmp/
docker run --name=haproxy -d \
    -v /tmp:/consul-template/template.d \
    -e CONSUL_LOGLEVEL=debug \
    -e CONSUL_CONNECT=192.168.12.34:8500 \
    asteris/haproxy-consul
