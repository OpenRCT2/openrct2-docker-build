# Default image that can build OpenRCT2 for Linux (amd64).
# Provides building with cmake+ninja using either gcc or clang.
FROM ubuntu:22.04
RUN apt-get update && \
    apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  # System
    ca-certificates curl file libcairo2 patchelf unzip \
  # Build tools
    git pkg-config ninja-build ccache g++ \
  # Build libraries
    libsdl2-dev libspeex-dev libspeexdsp-dev xz-utils \
    libflac-dev libogg-dev libvorbis-dev libopenal-dev \
    libcrypto++-dev libcurl4-openssl-dev libssl-dev \
    libfontconfig1-dev libfreetype6-dev \
    libicu-dev libpng-dev libzip-dev libzstd-dev \
    nlohmann-json3-dev \
  # Testing libraries
    libgtest-dev \
    software-properties-common gpg-agent

# Need to install ca-certificates before importing key
COPY llvm-snapshot.gpg.key /etc/apt/trusted.gpg.d/apt.llvm.org.asc
COPY llvm.list /etc/apt/sources.list.d
RUN apt-get update && \
    apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    clang-20
RUN add-apt-repository -y ppa:ecal/cmake-3.25 && apt install -y cmake

# Bash is required for OpenRCT2 CI
SHELL ["/bin/bash", "-c"]
