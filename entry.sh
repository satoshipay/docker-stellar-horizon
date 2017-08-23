#!/usr/bin/env bash

set -ue

function horizon_init_db() {
  echo "Initializing Horizon database..."
  horizon db init || echo "Horizon database initialization failed (possibly because it has been done before)"
}

horizon_init_db

exec "$@"
