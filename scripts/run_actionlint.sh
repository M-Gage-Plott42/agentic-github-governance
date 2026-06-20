#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ACTIONLINT_BIN="${ACTIONLINT_BIN:-}"

if [[ -z "$ACTIONLINT_BIN" ]]; then
  ACTIONLINT_BIN="$("$ROOT/scripts/install_actionlint.sh")"
fi

exec "$ACTIONLINT_BIN" "$@"
