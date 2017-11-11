# Stellar Horizon Docker image

[![Docker Build Status](https://img.shields.io/docker/build/satoshipay/stellar-horizon.svg)](https://hub.docker.com/r/satoshipay/stellar-horizon/)

## Docker Hub

The Docker images are automatically built and published at [satoshipay/stellar-horizon](https://hub.docker.com/r/satoshipay/stellar-horizon/).

## Configuration

All environment variables that Stellar Horizon accepts are supported. You can find out all available options by running `docker run --rm -it satoshipay/stellar-horizon horizon --help`. CLI options are exposed as upper/snake-case environment variables, e.g., `--stellar-core-url` can be set with the `STELLAR_CORE_URL` environment variable.

Make sure to set the following variables:

* `DATABASE_URL`: *Horizon* database URL, e.g., `postgres://horizon-db-host/stellar-horizon`.
* `STELLAR_CORE_DATABASE_URL`: *Stellar Core* database URL, e.g., `postgres://core-db-host/stellar-core`.
* `STELLAR_CORE_URL`: *Stellar Core* HTTP URL, e.g., `http://core-host:11626`.
* `INGEST`: ingest data from Stellar Core (true/false)
