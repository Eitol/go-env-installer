#!/usr/bin/env bash
INSTALL_DIR=/opt/omgGRPC
NW_VERSION=0.34.5
TARGET_PLATFORM=linux # linux, darwin, win32, sunos, freebsd, openbsd or aix
TARGET_ARCH=x64       # ia32 x64 or arm.
USER=`whoami`

sudo npm install -g nwjs node-pre-gyp nw-gyp
sudo nw install ${NW_VERSION}-sdk
git clone https://github.com/troylelandshields/omgrpc.git ${INSTALL_DIR}
cd ${INSTALL_DIR}
npm install
npm rebuild grpc --build-from-source --runtime=node-webkit --target=${NW_VERSION} --target_arch=${TARGET_ARCH} --target_platform=${TARGET_PLATFORM}

# RUN:
# nw .