FROM ubuntu:22.04

### Environment config
ENV HOME=/cs2110 \
    STARTUPDIR=/dockerstartup \
    INST_SCRIPTS=/cs2110/install \
    SRC_FILES=/cs2110/src \
    DEBIAN_FRONTEND=noninteractive
WORKDIR $HOME

### Add all install scripts for further steps
ADD ./src/install/ $INST_SCRIPTS/
RUN find $INST_SCRIPTS -name '*.sh' -exec chmod a+x {} +

### Apply any necessary patches during pre-installation
RUN $INST_SCRIPTS/patches/apply_preinstall_patches.sh

### Install some common tools and applications
RUN $INST_SCRIPTS/base/tools.sh
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

### Install man pages
RUN $INST_SCRIPTS/base/man_pages.sh

### Install gcc/gdb
RUN $INST_SCRIPTS/tools/cTools.sh

WORKDIR $HOME/host
ENTRYPOINT ["/bin/bash"]