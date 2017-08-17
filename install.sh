#!/usr/bin/env bash

set -ue

# install deps
apt-get update
apt-get install -y $STELLAR_HORIZON_BUILD_DEPS

# clone, compile, and install stellar core
git clone --branch $STELLAR_HORIZON_VERSION --recursive --depth 1 https://github.com/stellar/horizon.git

export GOPATH=/var/lib/go
mkdir -p $GOPATH
export PATH=$PATH:${GOPATH//://bin:}/bin

cd horizon
go get github.com/constabulary/gb/...
gb vendor restore
gb build
cp -a bin/* /usr/local/bin/

# cleanup
rm -rf horizon
apt-get remove -y $STELLAR_HORIZON_BUILD_DEPS
apt-get autoremove -y

# cleanup apt cache
rm -rf /var/lib/apt/lists/* $GOPATH
