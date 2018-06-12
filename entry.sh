#!/usr/bin/env bash

set -ue

function horizon_init_db() {
  echo "Initializing Horizon database..."
  horizon db init || echo "Horizon database initialization failed (possibly because it has been done before)"
}

if [ ! -z ${DATABASE_URL+x} ] && [ ! -z ${DATABASE_PASSWORD+x} ]; then
  export DATABASE_URL="${DATABASE_URL/DATABASE_PASSWORD/${DATABASE_PASSWORD}}"
fi

if [ ! -z ${STELLAR_CORE_DATABASE_URL+x} ] && [ ! -z ${STELLAR_CORE_DATABASE_PASSWORD+x} ]; then
  export STELLAR_CORE_DATABASE_URL="${STELLAR_CORE_DATABASE_URL/STELLAR_CORE_DATABASE_PASSWORD/${STELLAR_CORE_DATABASE_PASSWORD}}"
fi

horizon_init_db

exec "$@"
