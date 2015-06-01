#!/usr/bin/env bash

set -e

echo ""

echo "Retrieving docker images"
printf "  jeanblanchard/busybox-java:8..."
docker pull jeanblanchard/busybox-java:8

printf "  stigkj/registrator:v5.1..."
docker pull stigkj/registrator:v5.1

printf "  progrium/consul:latest..."
docker pull progrium/consul

printf "  asteris/haproxy-consul:latest..."
docker pull asteris/haproxy-consul

printf "  kiasaki/alpine-postgres:latest..."
docker pull kiasaki/alpine-postgres
