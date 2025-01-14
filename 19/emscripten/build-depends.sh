#!/bin/bash

START_DIR=/ext

cd $START_DIR

# Pin versions - to prevent sudden breakage
if [ ! -d "speexdsp" ]; then
    git clone https://gitlab.xiph.org/xiph/speexdsp.git --depth 1 --branch SpeexDSP-1.2.1
fi
if [ ! -d "icu" ]; then
    git clone https://github.com/unicode-org/icu.git --depth 1 --branch release-76-1
fi
if [ ! -d "libzip" ]; then
    git clone https://github.com/nih-at/libzip.git --depth 1 --branch v1.11.2
fi
if [ ! -d "zlib" ]; then
    git clone https://github.com/madler/zlib.git --depth 1 --branch v1.3.1
fi

cd speexdsp
emmake ./autogen.sh
emmake ./configure --enable-shared --disable-neon
emmake make -j$(nproc)
cd $START_DIR

cd icu/icu4c/source
ac_cv_namespace_ok=yes icu_cv_host_frag=mh-linux emmake ./configure \
    --enable-release \
    --enable-shared \
    --disable-icu-config \
    --disable-extras \
    --disable-icuio \
    --disable-layoutex \
    --disable-tools \
    --disable-tests \
    --disable-samples
emmake make -j$(nproc)
cd $START_DIR

cd zlib
emcmake cmake ./
emmake make zlib -j$(nproc)
emmake make install
ZLIB_ROOT=$(pwd)
cd $START_DIR

cd libzip
mkdir -p build/
cd build/
emcmake cmake ../ -DZLIB_INCLUDE_DIR="$ZLIB_ROOT" -DZLIB_LIBRARY="$ZLIB_ROOT/libz.a"
emmake make zip -j$(nproc)
emmake make install
