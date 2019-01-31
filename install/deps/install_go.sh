#!/usr/bin/env bash
## CONFIG
USR=`whoami`
SHARED_FOLDER=/home/${USR}/NAS

## GO CONFIG
GOVER='1.11.1'
GOPATH=/opt/go
GO_INSTALL_FOLDER=/usr/local/
GOROOT=${GO_INSTALL_FOLDER}/go

# Install deps
sudo apt update -ybuild-essentials
sudo apt dist-upgrade -y
apt install git make build-essentials -y

# Install go
sudo mkdir -p ${GOPATH}/src
sudo mkdir -p ${GOPATH}/pkg
sudo mkdir -p ${GOPATH}/bin
curl -O https://dl.google.com/go/go${GOVER}.linux-amd64.tar.gz
tar xvf go${GOVER}.linux-amd64.tar.gz
sudo mv go ${GO_INSTALL_FOLDER}
sudo chown -R root:root ${GOROOT}
sudo chown -R ${USR} ${GOPATH}
mv go${GOVER}.linux-amd64.tar.gz ${SHARED_FOLDER}

export GOROOT=${GOROOT}
export GOPATH=${GOPATH}
export PATH=$PATH:${GOROOT}/bin:${GOPATH}/bin
