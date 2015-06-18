#!/usr/bin/env bash

set -e

echo ""
echo "Installing monitoring cli..."

curl -s https://s3.amazonaws.com/download.draios.com/stable/install-sysdig | sudo bash
