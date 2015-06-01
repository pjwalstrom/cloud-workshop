#!/usr/bin/env bash

set -e

echo ""

if hash java 2> /dev/null; then
  echo "Already installed oracle jdk 8..."
else
  echo "Installing oracle jdk 8..."
  echo ""
  apt-get install --quiet --yes software-properties-common
  add-apt-repository ppa:webupd8team/java
  apt-get update
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
  apt-get install --quiet --yes oracle-java8-installer
fi

java -version
