#!/usr/bin/env bash

set -ue

# install deps
apt-get update
apt-get install -y $STELLAR_HORIZON_BUILD_DEPS $STELLAR_HORIZON_DEPS

# install horizon
wget https://github.com/stellar/go/releases/download/horizon-v${STELLAR_HORIZON_VERSION}/horizon-v${STELLAR_HORIZON_VERSION}-linux-amd64.tar.gz -O stellar-horizon.tar.gz
tar -zxvf stellar-horizon.tar.gz
mv horizon-v${STELLAR_HORIZON_VERSION}-linux-amd64/horizon /usr/local/bin
chmod +x /usr/local/bin/horizon

# cleanup
rm -rf stellar-horizon.tar.gz horizon-v${STELLAR_HORIZON_VERSION}-linux-amd64/
apt-get remove -y $STELLAR_HORIZON_BUILD_DEPS
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
