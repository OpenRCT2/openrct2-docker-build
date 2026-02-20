FROM docker.io/library/fedora:42

RUN dnf update -y && dnf install -y git cmake make gcc g++ nlohmann-json-devel autoreconf libtool openssl-devel libcurl-devel fontconfig-devel libzip-devel SDL2-devel zip ninja-build hostname ccache libatomic

WORKDIR /

RUN git clone https://github.com/emscripten-core/emsdk.git

WORKDIR /emsdk/

# Pin version - to prevent sudden breakage of the CI
RUN ./emsdk install 5.0.0
RUN ./emsdk activate 5.0.0

# "Install" json headers to emscripten include directory
RUN cp -r /usr/include/nlohmann /emsdk/upstream/emscripten/cache/sysroot/include/nlohmann

# Add emscripten to path
ENV PATH="/emsdk:/emsdk/upstream/emscripten:/emsdk/node/22.16.0_64bit/bin:$PATH"

WORKDIR /ext/

COPY build-depends.sh /ext/
COPY cors_serve.py /usr/bin/

# Build emscripten dependencies
RUN bash build-depends.sh

# Set ENV variables for icu and libzip
ENV ICU_ROOT="/ext/icu/icu4c/source"
ENV LIBZIP_ROOT="/ext/libzip/build"


SHELL ["/bin/bash", "-c"]
