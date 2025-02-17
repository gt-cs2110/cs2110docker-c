#!/bin/bash
# Useful for setting up a fresh WSL VM as if it is Docker
# (if Docker is busted on a student's machine)

set -e -o pipefail

export GBA=
export INST_SCRIPTS_DIRNAME=~/cs2110
export INST_SCRIPTS=$INST_SCRIPTS_DIRNAME/install
export DEBIAN_FRONTEND=noninteractive

SUDO_CMD=( sudo --preserve-env=INST_SCRIPTS,DEBIAN_FRONTEND )

mkdir -p "$INST_SCRIPTS_DIRNAME"

### Add all install scripts for further steps
cp -r ./src/install/ "$INST_SCRIPTS/"
find "$INST_SCRIPTS" -name '*.sh' -exec chmod a+x {} +

### Apply any necessary patches during pre-installation
"${SUDO_CMD[@]}" "$INST_SCRIPTS/patches/apply_preinstall_patches.sh"

### Install some common tools and applications
"${SUDO_CMD[@]}" "$INST_SCRIPTS/base/tools.sh"
export LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

### Install man pages
"${SUDO_CMD[@]}" "$INST_SCRIPTS/base/man_pages.sh"

### Install LC3 autograder
"${SUDO_CMD[@]}" "$INST_SCRIPTS/tools/lc3Tools.sh"

### Install gcc/gdb, mGBA (optional), and Criterion
"${SUDO_CMD[@]}" "$INST_SCRIPTS/tools/cTools.sh"
if [ -n "$GBA" ]; then "${SUDO_CMD[@]}" "$INST_SCRIPTS/tools/gba.sh"; fi

# Not necessary post-build
rm -rf "$INST_SCRIPTS_DIRNAME"
