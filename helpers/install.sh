#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

${SCRIPT_DIR}/install_docker_tools.sh
${SCRIPT_DIR}/retrieve_docker_images.sh


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
