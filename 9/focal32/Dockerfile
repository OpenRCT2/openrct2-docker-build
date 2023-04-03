# Default image that can build OpenRCT2 for Linux (i686).
# Provides building with cmake+ninja using gcc.
FROM ubuntu:20.04
RUN    dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y g++-multilib \
    # && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 60 \
    && apt-get update \
    && apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
      # System
         ca-certificates curl unzip \
      # Build tools
         git cmake ninja-build ccache \
         pkg-config:i386 \
      # Build libraries
         libsdl2-dev:i386 libspeex-dev:i386 libspeexdsp-dev:i386 \
         libflac-dev:i386 libogg-dev:i386 libvorbis-dev:i386 libopenal-dev:i386 \
         libcurl4-openssl-dev:i386 libssl-dev:i386 \
         libfontconfig1-dev:i386 libfreetype6-dev:i386 \
         libpng-dev:i386 libzip-dev:i386 libicu-dev:i386 \
         nlohmann-json3-dev \
      # Testing libraries
         libgtest-dev

# Bash is required for OpenRCT2 CI
SHELL ["/bin/bash", "-c"]
