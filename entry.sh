#!/usr/bin/env bash

set -ue


function horizon_init_db() {
  echo "Initializing Horizon database..."
  # use /dev/shm so that this works when / is mounted as read only
  OUT_FILE="$(mktemp -p /dev/shm)"
  while true; do
    set +e
    # capture both the output and the status code because sometimes horizon returns no output and
    # fails to migrate and other times it returns no output and succeeds and we need the status code
    # to tell the difference
    horizon db init > "$OUT_FILE" 2>&1
    EXIT="$?"
    set -e
    if ! [ -s $OUT_FILE ] && [ "$EXIT" = "0" ]; then
      echo Initialization successful.
      break
    elif grep "already exists" "$OUT_FILE" && [ "$EXIT" = "1" ]; then
      echo Initialization unnecessary.
      break
    else
      echo Initialization failed.
      cat "$OUT_FILE"
      sleep 1
    fi
  done
}

if [ ! -z ${DATABASE_URL+x} ] && [ ! -z ${DATABASE_PASSWORD+x} ]; then
  export DATABASE_URL="${DATABASE_URL/DATABASE_PASSWORD/${DATABASE_PASSWORD}}"
fi

if [ ! -z ${STELLAR_CORE_DATABASE_URL+x} ] && [ ! -z ${STELLAR_CORE_DATABASE_PASSWORD+x} ]; then
  export STELLAR_CORE_DATABASE_URL="${STELLAR_CORE_DATABASE_URL/STELLAR_CORE_DATABASE_PASSWORD/${STELLAR_CORE_DATABASE_PASSWORD}}"
fi

horizon_init_db

exec "$@"
