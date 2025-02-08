FROM ubuntu:22.04
ARG GBA

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

### Install gcc/gdb and mgba
RUN $INST_SCRIPTS/tools/cTools.sh
RUN if [ -n "$GBA" ]; then $INST_SCRIPTS/tools/gba.sh; fi

ARG TARGETPLATFORM

RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
        export PLATFORM_LIB="libcriterion_amd64.so"; \
		export PLATFORM_DIR="x86_64-linux-gnu"; \
    elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
        export PLATFORM_LIB="libcriterion_arm64.so"; \
		export PLATFORM_DIR="x86_64-linux-gnu"; \
    fi

ADD lib/libcriterion_amd64.so /criterion/libcriterion_amd64.so
ADD lib/libcriterion_arm64.so /criterion/libcriterion_arm64.so
RUN rm -f /usr/lib/${PLATFORM_DIR}/libcriterion.so*
RUN mv /criterion/${PLATFORM_LIB} /usr/lib/${PLATFORM_DIR}/libcriterion.so

RUN ldconfig

WORKDIR $HOME/host
ENTRYPOINT ["/bin/bash"]
