FROM gtcs2110/cs2110docker-c:stable

### Add all install scripts for further steps
ADD ./src/install-gba/ $INST_SCRIPTS/
RUN find $INST_SCRIPTS -name '*.sh' -exec chmod a+x {} +

RUN $INST_SCRIPTS/tools/gba.sh

# Not necessary post-build
RUN rm -rf $INST_SCRIPTS
WORKDIR $HOME/host
ENTRYPOINT ["/bin/bash"]
