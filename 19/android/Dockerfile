# Default image that can build OpenRCT2 for Android.
FROM ubuntu:24.04
RUN apt-get update && \
    apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  # System
    ca-certificates curl unzip \
  # Build tools
    git cmake pkg-config ninja-build ccache g++ \
  # Sprite builder libraries for the host
    libpng-dev \
    openjdk-21-jdk

ENV ANDROID_HOME=/android-dev
ENV ANDROID_NDK_HOME="$ANDROID_HOME/ndk"
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64

# Grab the Android SDK
WORKDIR /tmp/setup
RUN curl -Lo sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip \
 && unzip -qo sdk.zip \
 && mkdir -p $ANDROID_HOME/cmdline-tools \
 && mv cmdline-tools $ANDROID_HOME/cmdline-tools/latest \
 && rm sdk.zip

# Need nlohmann/json, needs to live outside system libraries, so it doesn't
# confuse toolchain to include other host headers
RUN curl -Lo json.zip https://github.com/nlohmann/json/releases/download/v3.11.3/include.zip \
 && unzip -qo json.zip -d json \
 && mkdir -p /opt/openrct2/include/ \
 && mv json/include/nlohmann /opt/openrct2/include/nlohmann \
 && rm json.zip

# Clean up
RUN rm -rf /tmp/setup
WORKDIR /

# Accept SDK licenses
RUN yes | "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" --licenses > /dev/null

# Install NDK
RUN "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" "ndk;27.2.12479018"
RUN "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" "cmake;3.31.1"
RUN "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" "build-tools;35.0.0"
RUN "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" "platforms;android-35"
RUN "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" "platform-tools"

# Bash is required for OpenRCT2 CI
SHELL ["/bin/bash", "-c"]
