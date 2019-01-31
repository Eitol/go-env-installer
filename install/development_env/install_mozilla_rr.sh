#!/usr/bin/env bash

sudo -S apt-get -y install ccache cmake make g++-multilib gdb \
  pkg-config coreutils python3-pexpect python-pexpect manpages-dev git \
  ninja-build capnproto libcapnp-dev

git clone https://github.com/mozilla/rr.git
mkdir rr_temp
cd rr_temp
cmake ..
make -j8
make test
make install
cd ..
rm -rf ./rr