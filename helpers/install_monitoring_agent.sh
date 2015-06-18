#!/usr/bin/env bash

set -e

echo ""
echo "Installing monitoring agent..."

curl -s https://s3.amazonaws.com/download.draios.com/stable/install-agent | sudo bash -s f7d743b4-3af5-4be6-b555-3b1df124ffa8 role:vagrant
