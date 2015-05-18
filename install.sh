#!/bin/bash

set -e

echo "Installing docker..."
echo ""
apt-get update
apt-get install --yes docker.io


echo
echo "Installing docker-compose..."
curl -Ls https://github.com/docker/compose/releases/download/1.2.0/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo
echo "Installing docker-machine..."
curl -Ls https://github.com/docker/machine/releases/download/v0.2.0/docker-machine_linux-amd64 > /usr/local/bin/docker-machine
chmod +x /usr/local/bin/docker-machine
docker-machine --version


# No need for maven which is preinstalled in the virtual machine
sudo -i -u vagrant rm -rf ~/bin/*

echo ""
echo "Installing Gradle..."
echo $HOME
echo ""
sudo -i -u vagrant /vagrant/gradlew -q --version

echo ""
echo "Initial build of project..."
echo ""
sudo -i -u vagrant /vagrant/gradlew -b /vagrant/build.gradle buildDocker -x test
