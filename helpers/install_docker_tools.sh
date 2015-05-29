#!/usr/bin/env bash

set -e

echo ""

if hash docker 2> /dev/null; then
  echo "Already installed docker..."
else
  echo "Installing docker..."
  echo ""
  echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
  apt-get update
  apt-get install --yes lxc-docker
  # Remove need for using sudo when running docker cli
  usermod -aG docker vagrant
fi

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
