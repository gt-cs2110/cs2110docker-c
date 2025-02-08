#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install LC-3 autograder utilities"
# Not to be confused with <https://github.com/gt-cs2110/lc3tools>, of course
apt-get update
apt-get install -y python3 python-is-python3 python3-pip
apt-get clean -y

pip3 install lc3-ensemble-test[std]

rm -rf /var/lib/apt/lists/*
