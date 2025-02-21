#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

apt-get update
apt-get install -y software-properties-common gpg-agent
add-apt-repository ppa:tricksterguy87/nin10kit

apt-get update

apt-get install -y nin10kit
# Note that the /usr/lib/arm-none-eabi/newlib/thumb directory from libnewlib-arm-none-eabi is excluded from installation, as it is very large and not needed.
apt-get install -y gcc-arm-none-eabi gdb-multiarch

apt-get install -y -o Dpkg::Options::="--path-exclude=/usr/lib/arm-none-eabi/newlib/thumb/*" libnewlib-arm-none-eabi

# GBA linker script; random oddities needed in the GBA Makefiles.
dpkg --force-architecture -i $INST_SCRIPTS/pkgs/cs2110-gba-linker-script_1.1.2-0ubuntu1~ppa1~bionic1_amd64.deb
rm $INST_SCRIPTS/pkgs/cs2110-gba-linker-script_1.1.2-0ubuntu1~ppa1~bionic1_amd64.deb

# MGBA emulator
# Unfortunately apt-get install mgba-qt will get you a very outdated version
# the deb packages are released directly on github
if [[ $(dpkg --print-architecture) = "arm64" ]]; then
    # No package for ARM so I had to build from source
    # TODO: find a better solution

    # Install dependencies
    apt-get install -y libsdl2-2.0-0 libopengl0 libzip4 # libqt5widgets5 libqt5core5a libqt5gui5 libqt5multimedia5 libqt5opengl5 
    
    # Extract tarball with binaries
    tar -zxvf $INST_SCRIPTS/pkgs/mgba_0.10.1-jammy_arm64.tar.gz -C /
    ldconfig
else
    apt-get install -y $INST_SCRIPTS/pkgs/libmgba_0.10.1-jammy.deb
    # apt-get install -y $INST_SCRIPTS/pkgs/mgba-qt_0.10.1-jammy.deb
fi
rm $INST_SCRIPTS/pkgs/libmgba_0.10.1-jammy.deb
rm $INST_SCRIPTS/pkgs/mgba-qt_0.10.1-jammy.deb
rm $INST_SCRIPTS/pkgs/mgba_0.10.1-jammy_arm64.tar.gz

# Necessary config to get mgba to not run super fast, custom button keymapping, and other niceties.
mkdir -p $HOME/.config/mgba
cp $INST_SCRIPTS/configs/mgba-config.ini $HOME/.config/mgba/config.ini

rm -rf /var/lib/apt/lists/*