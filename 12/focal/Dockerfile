# Default image that can build OpenRCT2 for Linux (amd64).
# Provides building with cmake+ninja using either gcc or clang.
FROM ubuntu:20.04
RUN apt-get update && \
    apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  # System
    ca-certificates curl file libcairo2 patchelf unzip \
  # Build tools
    git cmake pkg-config ninja-build ccache g++ clang \
  # Build libraries
    libsdl2-dev libspeex-dev libspeexdsp-dev \
    libflac-dev libogg-dev libvorbis-dev libopenal-dev \
    libcrypto++-dev libcurl4-openssl-dev libssl-dev \
    libfontconfig1-dev libfreetype6-dev \
    libicu-dev libpng-dev libzip-dev \
    nlohmann-json3-dev \
  # Testing libraries
    libgtest-dev

# Bash is required for OpenRCT2 CI
SHELL ["/bin/bash", "-c"]
