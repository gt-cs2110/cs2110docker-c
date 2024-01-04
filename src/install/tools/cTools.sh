#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install gcc/gdb"
apt-get update
apt-get install -y gcc gdb build-essential libc6 pkg-config check valgrind cmake vim
apt-get clean -y

rm -rf /var/lib/apt/lists/*