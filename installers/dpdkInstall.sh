#!/bin/bash

# Utility script that automates the download, build configuration, compilation,
# and installation process for a stable dpdk library release.

# Install DPDK's dependencies
echo "Install DPDK Dependencies"
apt-get update
apt-get install -y make gcc gcc-multilib linux-headers-$(uname -r) libnuma-dev

# It seems easier to get static DPDK library to work based on our experience.
# For example, as of 04/2018, we haven't been able to get MLX4 driver to work
# with DPDK shared libraries on the CloudLab m510 cluster.
DPDK_OPTIONS+=" CONFIG_RTE_BUILD_SHARED_LIB=n"

# Download the latest stable release.
DPDK_VER="18.11.2"
DPDK_SRC="https://fast.dpdk.org/rel/dpdk-${DPDK_VER}.tar.xz"
DPDK_DIR="dpdk-stable-${DPDK_VER}"

echo "Install DPDK $DPDK_VER"
pushd /usr/local/src
wget --no-clobber ${DPDK_SRC}
tar xvf dpdk-${DPDK_VER}.tar.xz
rm dpdk-${DPDK_VER}.tar.xz

# Build the libraries, assuming an x86_64 linux target, and a gcc-based
# toolchain. Compile position-indepedent code, which will be linked by
# application code, and produce a unified object archive file.
TARGET=x86_64-native-linuxapp-gcc
NUM_JOBS=`grep -c '^processor' /proc/cpuinfo`
if [ "$NUM_JOBS" -gt 2 ]; then
    let NUM_JOBS=NUM_JOBS-2
fi

cd ${DPDK_DIR}
make config T=$TARGET O=$TARGET
cd $TARGET
sed -ri 's,(MLX._PMD=)n,\1y,' .config
# TODO: why do you need fPIC for static library???
make clean; make $DPDK_OPTIONS EXTRA_CFLAGS="-fPIC" -j$NUM_JOBS
make install

popd
