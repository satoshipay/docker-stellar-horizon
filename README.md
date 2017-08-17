# Stellar Horizon Docker image

## Configuration

All environment variables that Stellar Horizon supports are supported. You can find out all available options by running `docker run --rm -it stellar-horizon horizon --help`. T

* `DATABASE_URL`: *Horizon* database URL, e.g., `postgres://horizon-db-host/stellar-horizon`.
* `STELLAR_CORE_DATABASE_URL`: *Stellar Core* database URL, e.g., `postgres://core-db-host/stellar-core`.
* `STELLAR_CORE_URL`: *Stellar Core* HTTP URL, e.g., `http://core-host:11626`.
* `INGEST`: ingest data from Stellar Core (true/false)
