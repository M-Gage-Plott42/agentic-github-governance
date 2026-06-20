#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION="${ACTIONLINT_VERSION:-1.7.12}"
TOOLS_DIR="${ACTIONLINT_TOOLS_DIR:-$ROOT/.tools/actionlint}"
BIN_DIR="$TOOLS_DIR/$VERSION/bin"
BIN="$BIN_DIR/actionlint"

if [[ -x "$BIN" ]]; then
  printf '%s\n' "$BIN"
  exit 0
fi

case "$(uname -s)" in
  Linux)
    os="linux"
    ;;
  Darwin)
    os="darwin"
    ;;
  *)
    echo "[ERROR] Unsupported actionlint OS: $(uname -s)" >&2
    exit 2
    ;;
esac

case "$(uname -m)" in
  x86_64|amd64)
    arch="amd64"
    ;;
  aarch64|arm64)
    arch="arm64"
    ;;
  *)
    echo "[ERROR] Unsupported actionlint architecture: $(uname -m)" >&2
    exit 2
    ;;
esac

asset="actionlint_${VERSION}_${os}_${arch}.tar.gz"
checksum_file="actionlint_${VERSION}_checksums.txt"
base_url="https://github.com/rhysd/actionlint/releases/download/v${VERSION}"
tmpdir="$(mktemp -d)"

cleanup() {
  rm -rf "$tmpdir"
}
trap cleanup EXIT

curl -fsSLo "$tmpdir/$asset" "$base_url/$asset"
curl -fsSLo "$tmpdir/$checksum_file" "$base_url/$checksum_file"

(
  cd "$tmpdir"
  checksum_line="$(grep "  ${asset}$" "$checksum_file" || true)"
  if [[ -z "$checksum_line" ]]; then
    echo "[ERROR] No checksum entry found for $asset" >&2
    exit 2
  fi

  if command -v sha256sum >/dev/null 2>&1; then
    printf '%s\n' "$checksum_line" | sha256sum -c - >&2
  elif command -v shasum >/dev/null 2>&1; then
    printf '%s\n' "$checksum_line" | shasum -a 256 -c - >&2
  else
    echo "[ERROR] Need sha256sum or shasum to verify actionlint." >&2
    exit 2
  fi

  tar -xzf "$asset" actionlint
)

mkdir -p "$BIN_DIR"
install -m 0755 "$tmpdir/actionlint" "$BIN"
printf '%s\n' "$BIN"
