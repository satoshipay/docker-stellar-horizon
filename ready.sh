#!/usr/bin/env bash

set -eu pipefail

MAX_LEDGER_LAG=10

CORE_INFO=$(curl --silent --max-time 1 --retry 3 --retry-delay 1 ${STELLAR_CORE_URL}/info)
CORE_STATE=$(jq -r .info.state <<< "${CORE_INFO}")
if [ "${CORE_STATE}" != "Synced!" ]; then
  >&2 echo "Expected Core state \"Synced!\" but got \"${CORE_STATE}\""
  exit 1
fi

CORE_LEDGER=$(jq -r .info.ledger.num <<< "${CORE_INFO}")
HORIZON_LEDGER=$(curl --silent --max-time 1 http://localhost:8000 | jq -r .history_latest_ledger)
if (( HORIZON_LEDGER < CORE_LEDGER - MAX_LEDGER_LAG )); then
  >&2 echo "Horizon ledger ${HORIZON_LEDGER} lagging more than ${MAX_LEDGER_LAG} ledgers behind Core ledger ${CORE_LEDGER}"
  exit 1
fi
