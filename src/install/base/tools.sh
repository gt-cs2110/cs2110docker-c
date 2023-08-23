#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation"
apt-get update
apt-get install -y wget net-tools locales bzip2 zip unzip
apt-get clean -y

echo "generate locales für en_US.UTF-8"
locale-gen en_US.UTF-8

rm -rf /var/lib/apt/lists/*
