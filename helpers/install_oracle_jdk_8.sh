#!/usr/bin/env bash

set -e

echo ""

if hash java 2> /dev/null; then
  echo "Already installed oracle jdk 8..."
else
  echo "Installing oracle jdk 8..."
  echo ""
  add-apt-repository ppa:webupd8team/java
  apt-get update
  apt-get install oracle-java8-installer
fi

java -version
