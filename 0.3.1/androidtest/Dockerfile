# Default image that can build OpenRCT2 for Android.
FROM ubuntu:18.04
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install --no-install-recommends -y \
  # System
    ca-certificates curl unzip \
  # Build tools
    git cmake pkg-config ninja-build ccache g++ \
  # Build libraries
    libsdl2-dev libspeex-dev libspeexdsp-dev \
    libcrypto++-dev libcurl4-openssl-dev libssl-dev \
    libfontconfig1-dev libfreetype6-dev \
    libicu-dev libjansson-dev libpng-dev libzip-dev

# Get JDK
RUN apt-get -y install openjdk-8-jdk

ENV ANDROID_HOME=/android-dev
ENV ANDROID_NDK_HOME="$ANDROID_HOME/ndk"
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Grab the Android SDK
WORKDIR /tmp/setup
RUN curl -Lo sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
 && unzip -qo sdk.zip \
 && mkdir $ANDROID_HOME \
 && mv tools $ANDROID_HOME

# Grab the Android NDK
RUN curl -Lo ndk.zip https://dl.google.com/android/repository/android-ndk-r21d-linux-x86_64.zip \
 && unzip -qo ndk.zip \
 && mv android-ndk-* "$ANDROID_NDK_HOME"

RUN curl -Lo json.zip https://github.com/nlohmann/json/releases/download/v3.9.1/include.zip \
 && unzip -qo json.zip -d json \
 && mv json/include/nlohmann /nlohmann

# Clean up
RUN rm -rf /tmp/setup
WORKDIR /

# Accept SDK licenses
RUN yes | "$ANDROID_HOME/tools/bin/sdkmanager" --licenses > /dev/null

# Bash is required for OpenRCT2 CI
SHELL ["/bin/bash", "-c"]
