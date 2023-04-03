FROM archlinux:latest

# Based on https://github.com/haffmans/docker-mingw-qt5/blob/master/Dockerfile

# Update base system
#RUN    pacman -Sy --noconfirm --noprogressbar archlinux-keyring \
#    && pacman-key --populate \
RUN    pacman -Syu --noconfirm --noprogressbar pacman \
    && pacman-db-upgrade \
    && pacman -Su --noconfirm --noprogressbar ca-certificates \
    && trust extract-compat \
    && pacman -Su --noconfirm --noprogressbar git pyalpm base-devel libffi \
    && pacman -Syyu --noconfirm --noprogressbar \
    && (echo -e "y\ny\n" | pacman -Scc)

# Install pikaur
RUN useradd --create-home --comment "Arch Build User" build && \
    groupadd sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers; \
    echo 'Defaults:nobody !requiretty' >> /etc/sudoers; \
    gpasswd -a build sudo

RUN chown -R build /home/build

USER build
# Overrides from arch-base
ENV HOME /home/build

WORKDIR /home/build/
RUN git clone https://aur.archlinux.org/pikaur.git

WORKDIR /home/build/pikaur
RUN makepkg -sr --noconfirm

USER root
RUN pacman -U pikaur-*.zst --noconfirm && pacman -Scc --noconfirm && rm -r /home/build/*

# Add some useful packages to the base system
RUN pacman -S --noconfirm --noprogressbar \
        make \
        git \
        sudo \
        wget \
        awk \
        sudo \
        fakeroot \
        file \
        patch \
        ninja \
        ccache \
        unzip \
    && (echo -e "y\ny\n" | pacman -Scc)

# Add ownstuff repo
# See https://wiki.archlinux.org/index.php/unofficial_user_repositories#ownstuff and https://martchus.no-ip.biz/repoindex/#packages
RUN    echo "[ownstuff]" >> /etc/pacman.conf \
    && echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf \
    && echo "Server = https://ftp.f3l.de/~martchus/\$repo/os/\$arch" >> /etc/pacman.conf \
    && echo "Server = https://martchus.no-ip.biz/repo/arch/\$repo/os/\$arch" >> /etc/pacman.conf \
    && pacman -Sy

USER build
# Install MingW packages
RUN pikaur -S --noconfirm --noprogressbar \
        mingw-w64-binutils \
        mingw-w64-bzip2 \
        mingw-w64-boost \
        mingw-w64-cmake \
        mingw-w64-crt \
        mingw-w64-curl \
        mingw-w64-flac \
        mingw-w64-fontconfig \
        mingw-w64-freetype2 \
        mingw-w64-gcc \
        mingw-w64-gnutls \
        mingw-w64-headers \
        mingw-w64-libiconv \
        mingw-w64-libogg \
        mingw-w64-libpng \
        mingw-w64-libvorbis \
        mingw-w64-nettle \
        mingw-w64-openal \
        mingw-w64-openssl \
        mingw-w64-pkg-config \
        mingw-w64-sdl2 \
        mingw-w64-speexdsp \
        mingw-w64-tools \
        mingw-w64-winpthreads \
        mingw-w64-xz \
        mingw-w64-zlib \
        pkgconf \
    && (echo -e "y\ny\n" | sudo pacman -Scc)

WORKDIR /home/build/
COPY mingw-w64-libzip mingw-w64-libzip
USER root
# GMP and Nettle seem to have their mingw libraries misnamed. pkg-config
# points to .a, not .dll.a files; additionally cmake removes any such
# extensions, so symlink the files to their expected places
RUN    ln -s /usr/i686-w64-mingw32/lib/libp11-kit.dll.a /usr/i686-w64-mingw32/lib/libp11-kit.a \
    && ln -s /usr/i686-w64-mingw32/lib/libgmp.dll.a /usr/i686-w64-mingw32/lib/libgmp.a
# Brotli has different names for static and non-static libraries, but
# pkg-config only knows the non-static ones. Brotli is required by freetype2
RUN    ln -s /usr/i686-w64-mingw32/lib/libbrotlicommon-static.a /usr/i686-w64-mingw32/lib/libbrotlicommon.a \
    && ln -s /usr/i686-w64-mingw32/lib/libbrotlidec-static.a /usr/i686-w64-mingw32/lib/libbrotlidec.a
RUN chown -R build /home/build
USER build
WORKDIR /home/build/mingw-w64-libzip
RUN makepkg -sr --noconfirm
USER root
RUN pacman -U mingw-w64-libzip-*.zst --noconfirm && pacman -Scc --noconfirm && rm -r /home/build/*

RUN	wget https://github.com/nlohmann/json/releases/download/v3.11.2/include.zip -O /usr/i686-w64-mingw32/json.zip && unzip /usr/i686-w64-mingw32/json.zip -d /usr/i686-w64-mingw32/ && unzip /usr/i686-w64-mingw32/json.zip -d /usr/x86_64-w64-mingw32/

# Bash is required for OpenRCT2 CI
SHELL ["/bin/bash", "-c"]
