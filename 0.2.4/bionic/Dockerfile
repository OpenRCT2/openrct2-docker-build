# Default image that can build OpenRCT2 for Linux (amd64).
# Provides building with cmake+ninja using either gcc or clang.
FROM ubuntu:18.04
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install --no-install-recommends -y \
  # System
    ca-certificates \
  # Build tools
    git cmake pkg-config ninja-build ccache g++ clang-5.0 \
  # Build libraries
    libsdl2-dev libspeex-dev libspeexdsp-dev \
    libcrypto++-dev libcurl4-openssl-dev libssl-dev \
    libfontconfig1-dev libfreetype6-dev \
    libicu-dev libjansson-dev libpng-dev libzip-dev \
  # Testing libraries
    libgtest-dev && \
  # Create symbolic links
    ln -s /usr/bin/clang-5.0 /usr/bin/clang && \
    ln -s /usr/bin/clang++-5.0 /usr/bin/clang++

# Bash is required for OpenRCT2 CI
SHELL ["/bin/bash", "-c"]
