#!/usr/bin/env bash

set -eu pipefail

MAX_LEDGER_LAG=10

CORE_LEDGER=$(curl --silent --max-time 2 ${STELLAR_CORE_URL}/info | jq -r .info.ledger.num)
HORIZON_LEDGER=$(curl --silent --max-time 2 http://localhost:8000 | jq -r .history_latest_ledger)

if (( HORIZON_LEDGER < CORE_LEDGER - MAX_LEDGER_LAG )); then
  >&2 echo "Horizon ledger ${HORIZON_LEDGER} lagging more than ${MAX_LEDGER_LAG} ledgers behind Core ledger ${CORE_LEDGER}"
  exit 1
fi
