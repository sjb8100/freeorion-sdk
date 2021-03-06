# This Dockerfile contains build instructions to create a working and C++11
# capable build environment for FreeOrion on TravisCI.  The image is available
# via `freeorion/freeorion-travis-build`.

# Docker doesn't expose any feature to check if a Dockerfile would result in
# some tagged image on the docker registry for various reasons (hard to restore
# Dockerfile from fs-metadata, no return code for an recreated build from cache
# when using `docker build`, different file timestamps in fs-layers when running
# `apt-get`, apt-get not pulling consistent packages, …).  To circument this a
# custom label called `version` is used. Whenever a new image should be deployed
# the version label value needs to be increased by one.

# coreutils is included to use timeout in travis-ci builds

FROM docker.io/ubuntu:xenial-20180417

LABEL version="8" \
      maintainer="Marcel Metz <mmetz@adrian-broher.net>"

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "# don't install documentation inside container\n\
path-exclude=/usr/share/doc/*\n\
path-exclude=/usr/share/man/*\n\
path-exclude=/usr/share/cmake-3.5/Help/*\n\
" > /etc/dpkg/dpkg.cfg.d/docker-no-documentation

RUN echo "# don't install static libraries inside container\n\
path-exclude=/usr/lib/x86_64-linux-gnu/*.a\n\
path-exclude=/usr/lib/python2.7/config-x86_64-linux-gnu/*.a\n\
path-include=/usr/lib/x86_64-linux-gnu/libc_nonshared.a\n\
path-include=/usr/lib/gcc/x86_64-linux-gnu/5/libgcc.a\n\
path-include=/usr/lib/x86_64-linux-gnu/libmvec_nonshared.a\n\
path-include=/usr/lib/x86_64-linux-gnu/libpthread.a\n\
path-include=/usr/lib/x86_64-linux-gnu/libpthread-2.0.a\n\
path-include=/usr/lib/x86_64-linux-gnu/libpthread_nonshared.a\n\
" > /etc/dpkg/dpkg.cfg.d/docker-no-static-libraries

RUN echo "# don't install recommends and suggests packages\n\
APT::Install-Recommends \"false\";\n\
APT::Install-Suggests \"false\";\n\
" > /etc/apt/apt.conf.d/docker-no-suggests

RUN apt-get update --assume-yes \
    && apt-get install --assume-yes \
        git \
        g++ \
        cmake \
        python \
        doxygen \
        ccache \
        coreutils \
        libpython-dev \
        libfreetype6-dev \
        libglew-dev \
        libopenal-dev \
        libogg-dev \
        libvorbis-dev \
        zlib1g-dev \
        libsdl2-dev \
        mesa-common-dev \
        libfreetype6-dev \
        libpng12-dev \
        libboost-thread-dev \
        libboost-system-dev \
        libboost-signals-dev \
        libboost-serialization-dev \
        libboost-regex-dev \
        libboost-python-dev \
        libboost-log-dev \
        libboost-iostreams-dev \
        libboost-locale-dev \
        libboost-filesystem-dev \
        libboost-date-time-dev \
        libboost-test-dev \
    && rm -rf \
        /var/lib/apt/lists/*
