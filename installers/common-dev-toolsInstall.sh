#! /bin/bash

# Install a number of common development tools
echo "Install common dev tools"
apt-get update
apt-get install -y gcc g++ ninja-build doxygen 
