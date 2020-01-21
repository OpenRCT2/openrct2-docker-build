# openrct2-docker-build
This repository contains dockerfiles for images used to build OpenRCT2 on GitHub Actions. They can also be used for OpenRCT2 development.

To use these images for development, first checkout the sources for OpenRCT2 and then run an interactive container with a mounted directory to your OpenRCT2 checkout. Once the container shell has launched, you can build it using cmake and ninja.

Example:
```
$ git checkout https://github.com/OpenRCT2/OpenRCT2.git /tmp/openrct2-src
$ docker run --rm -w /w -v /tmp/openrct2-src:/w -it openrct2/openrct2-build
  $ mkdir -p bin && cd bin
  $ cmake .. -G Ninja
  $ ninja
  $ ./openrct2 --version
```

## Tags

Distributed builds of OpenRCT2 for Linux are currently built by Ubuntu 18.04.

- [`latest`, `0.2.4`, `0.2.4-bionic` (*0.2.4/bionic/Dockerfile*)](https://github.com/OpenRCT2/openrct2-docker-build/blob/master/0.2.4/bionic/Dockerfile)
- [`0.2.4-bionic32` (*0.2.4/bionic32/Dockerfile*)](https://github.com/OpenRCT2/openrct2-docker-build/blob/master/0.2.4/bionic32/Dockerfile)
- [`0.2.4-format` (*0.2.4/format/Dockerfile*)](https://github.com/OpenRCT2/openrct2-docker-build/blob/master/0.2.4/format/Dockerfile)
- [`0.2.4-mingw` (*0.2.4/mingw/Dockerfile*)](https://github.com/OpenRCT2/openrct2-docker-build/blob/master/0.2.4/mingw/Dockerfile)
