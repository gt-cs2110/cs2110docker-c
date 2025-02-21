#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation"
apt-get update
apt-get install -y wget net-tools locales bzip2 zip unzip
# For people working in Git repositories in a dev container,
# (e.g., AG devs for C or superuser students)
apt-get install -y git
apt-get clean -y

echo "generate locales für en_US.UTF-8"
locale-gen en_US.UTF-8

rm -rf /var/lib/apt/lists/*
