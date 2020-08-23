# Image specifically designed to build OpenRCT2 for Windows using mingw.
FROM openrct2/openrct2:mingw-arch
USER root
RUN    pacman -Sy --noconfirm --noprogressbar nlohmann-json \
    && (echo -e "y\ny\n" | pacman -Scc)

# Bash is required for OpenRCT2 CI
SHELL ["/bin/bash", "-c"]
