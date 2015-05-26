#!/bin/bash

set -e

echo "Installing docker..."
echo ""
echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
apt-get update
apt-get install --yes lxc-docker
# Remove need for using sudo when running docker cli
usermod -aG docker vagrant


echo ""
echo "Retrieving docker images"
printf "  jeanblanchard/busybox-java:8..."
docker pull jeanblanchard/busybox-java:8
docker pull gliderlabs/registrator
docker pull progrium/consul
docker pull asteris/haproxy-consul

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
    gliderlabs/registrator -ip 192.168.12.34 consul://192.168.12.34:8500

docker run --name=haproxy -d \
    -v /vagrant/helpers:/consul-template/template.d \
    -e SERVICE_IGNORE=true \
    -e CONSUL_LOGLEVEL=debug \
    -e CONSUL_CONNECT=192.168.12.34:8500 \
    asteris/haproxy-consul


echo ""


if hash docker-compose 2> /dev/null; then
  echo "Already installed docker-compose..."
else
  echo "Installing docker-compose..."
  curl -Ls https://github.com/docker/compose/releases/download/1.2.0/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
fi

docker-compose --version


echo ""

if hash docker-machine 2> /dev/null; then
  echo "Already installed docker-machine..."
else
  echo "Installing docker-machine..."
  curl -Ls https://github.com/docker/machine/releases/download/v0.2.0/docker-machine_linux-amd64 > /usr/local/bin/docker-machine
  chmod +x /usr/local/bin/docker-machine
fi

docker-machine --version


# All done below here is run as the vagrant user

# No need for maven which is preinstalled in the virtual machine
sudo -i -u vagrant rm -rf bin

echo ""
echo "Installing Gradle..."
echo ""
sudo -i -u vagrant /vagrant/gradlew -q --version

echo ""
echo "Initial build of project..."
echo ""
sudo -i -u vagrant /vagrant/gradlew -b /vagrant/build.gradle buildDocker -x test
