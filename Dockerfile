# This Dockerfile contains build instructions to create a working and C++11
# capable build environment for FreeOrion on TravisCI.  The image is available
# via `freeorion/freeorion-travis-build`.

FROM docker.io/ubuntu:16.04
MAINTAINER Marcel Metz <mmetz@adrian-broher.net>
RUN apt-get update --assume-yes \
    && apt-get install --assume-yes --no-install-recommends \
        g++ \
        cmake \
        python \
        doxygen \
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
    && rm -rf \
        /var/lib/apt/lists/* \
        /usr/share/cmake-3.5/Help \
        /usr/share/doc/libasound2-dev/examples \
        /usr/share/doc/libasound2/examples \
        /usr/share/doc/libboost-date-time1.58-dev/data \
        /usr/share/doc/libexpat1-dev/examples \
        /usr/share/doc/libexpat1-dev/expat.html \
        /usr/share/doc/libfreetype6/css \
        /usr/share/doc/libfreetype6/design \
        /usr/share/doc/libfreetype6/reference \
        /usr/share/doc/libfreetype6/tutorials \
        /usr/share/doc/libfreetype6/image \
        /usr/share/doc/libfreetype6/glyphs \
        /usr/share/doc/libicu-dev/examples \
        /usr/share/doc/libogg-dev/html \
        /usr/share/doc/libvorbis-dev/html
RUN apt-get update --assume-yes \
    && apt-get install --assume-yes --no-install-recommends \
        git \
    && rm -rf \
        /var/lib/apt/lists/* \