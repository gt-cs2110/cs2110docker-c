FROM ubuntu:22.04
ARG GBA
ARG TARGETPLATFORM

ENV REFRESHED_AT=2024-01-04
ENV CS2110_IMAGE_VERSION=1.1.0

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

### Install LC3 autograder
RUN $INST_SCRIPTS/tools/lc3Tools.sh

### Install gcc/gdb, mGBA (optional), and Criterion
RUN $INST_SCRIPTS/tools/cTools.sh

# Not necessary post-build
RUN rm -rf $INST_SCRIPTS
WORKDIR $HOME/host
ENTRYPOINT ["/bin/bash"]
