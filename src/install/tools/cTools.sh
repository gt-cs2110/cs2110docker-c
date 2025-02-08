#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install gcc/gdb"
apt-get update
apt-get install -y gcc gdb build-essential libc6 pkg-config libcriterion-dev valgrind cmake vim
apt-get clean -y

rm -rf /var/lib/apt/lists/*

# Install (slightly more up-to-date version of) Criterion from prebuilt object files
if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
    export PLATFORM_LIB="libcriterion_amd64.so"; \
    export PLATFORM_DIR="x86_64-linux-gnu"; \
elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
    export PLATFORM_LIB="libcriterion_arm64.so"; \
    export PLATFORM_DIR="aarch64-linux-gnu"; \
fi

rm -f /usr/lib/${PLATFORM_DIR}/libcriterion.so*
mv $INST_SCRIPTS/lib/${PLATFORM_LIB} /usr/lib/${PLATFORM_DIR}/libcriterion.so

ldconfig