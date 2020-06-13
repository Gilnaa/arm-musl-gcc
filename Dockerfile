
FROM debian:buster
MAINTAINER Gilad Naaman <gilad@naaman.io>
ENV FORCE_UNSAFE_CONFIGURE=1
# Install build tools
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -yy && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yy \
        automake            \
        build-essential     \
        curl                \
        flex                \
        libtool             \
        pkg-config          \
        texinfo             \
        vim                 \
        wget                \
        cpio                \
        unzip               \
        rsync		    \
        bc

RUN wget https://buildroot.org/downloads/buildroot-2020.02.3.tar.bz2 && \
    tar xf buildroot-2020.02.3.tar.bz2 

COPY buildroot_config buildroot-2020.02.3/.config

RUN cd buildroot* && make toolchain && \
	mv /buildroot-2020.02.3/output/host /toolchain && \
	rm -rf /buildroot-2020.02.3
RUN apt-get clean &&                                                    \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PATH $PATH:/toolchain/bin
ENV LD_LIBRARY_PATH /toolchain/lib

RUN useradd builder --user-group --create-home --uid=1000 --shell /bin/bash
USER builder
WORKDIR /home/builder
CMD /bin/bash

