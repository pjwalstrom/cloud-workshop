#!/bin/sh

# No need for maven which is preinstalled in the virtual machine
rm -rf ~/bin/*

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

echo
echo "Initial build of project"
# Just to make sure gradle and the build's dependencies are downloaded
/vagrant/gradlew build
