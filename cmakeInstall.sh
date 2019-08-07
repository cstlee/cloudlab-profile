#! /bin/bash

# Download and Install the specified version of CMake
CMAKE_VERSION=3.15.2
CMAKE_INSTALLER=cmake-$CMAKE_VERSION-Linux-x86_64.sh
CMAKE_SOURCE=https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION

pushd /tmp
wget $CMAKE_SOURCE/$CMAKE_INSTALLER
/bin/sh $CMAKE_INSTALLER --prefix=/usr/local/ --skip-license  --exclude-subdir
rm $CMAKE_INSTALLER 
popd

