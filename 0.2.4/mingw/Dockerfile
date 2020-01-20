# Image specifically designed to build OpenRCT2 for Windows using mingw.
FROM archlinux

# Update base system, install sudo and create our sudo user
RUN    echo "[mingw-w64]" >> /etc/pacman.conf \
    && echo "SigLevel = Optional TrustAll" >> /etc/pacman.conf \
    && echo "Server = https://downloads.sourceforge.net/project/mingw-w64-archlinux/\$arch" >> /etc/pacman.conf \
    && pacman -Syyu --noconfirm --noprogressbar binutils cmake fakeroot gcc git go make ninja sudo \
    && (echo -e "y\ny\n" | pacman -Scc) \
    && echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && groupadd sudo \
    && useradd -mG sudo builder

# Install MingW packages
RUN pacman -S --noconfirm --noprogressbar \
        mingw-w64-boost \
        mingw-w64-cmake \
        mingw-w64-crt \
        mingw-w64-curl \
        mingw-w64-fontconfig \
        mingw-w64-freetype2 \
        mingw-w64-headers \
        mingw-w64-libiconv \
        mingw-w64-libpng \
        mingw-w64-openssl \
        mingw-w64-pkg-config \
        mingw-w64-sdl2 \
        mingw-w64-tools \
        mingw-w64-winpthreads \
        mingw-w64-zlib \
    && (echo -e "y\ny\n" | pacman -Scc)# 

# Switch to our sudo user so we can use makepkg
USER builder

# Install an AUR helper
RUN    git clone https://aur.archlinux.org/yay.git /tmp/yay \
    && cd /tmp/yay \
    && makepkg -si --noconfirm --noprogressbar \
    && rm -rf /tmp/yay

# Install packages only available on AUR
RUN yay -S --noconfirm --noprogressbar \
        mingw-w64-jansson \
        aur/mingw-w64-libzip \
        aur/mingw-w64-speexdsp \
    && (echo -e "y\ny\n" | sudo pacman -Scc)

# Bash is required for OpenRCT2 CI
SHELL ["/bin/bash", "-c"]
