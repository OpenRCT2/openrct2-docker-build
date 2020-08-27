# Default image that can build OpenRCT2 for Linux (i686).
# Provides building with cmake+ninja using gcc.
FROM ubuntu:18.04
RUN    dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y g++-7-multilib \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 60 \
    && apt-get update \
    && apt-get -y upgrade \
    && apt-get install --no-install-recommends -y \
      # System
         ca-certificates curl \
      # Build tools
         git cmake ninja-build ccache \
         pkg-config:i386 \
      # Build libraries
         libsdl2-dev:i386 libspeex-dev:i386 libspeexdsp-dev:i386 \
         libcrypto++-dev:i386 libcurl4-openssl-dev:i386 libssl-dev:i386 \
         libfontconfig1-dev:i386 libfreetype6-dev:i386 \
         libpng-dev:i386 libzip-dev:i386 libicu-dev:i386 \
         duktape-dev:i386

RUN mkdir /usr/include/nlohmann && \
	curl https://github.com/nlohmann/json/releases/download/v3.9.1/json.hpp -Lo /usr/include/nlohmann/json.hpp

# Bash is required for OpenRCT2 CI
SHELL ["/bin/bash", "-c"]
