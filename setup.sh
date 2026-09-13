#!/bin/bash
set -euo pipefail

QUEUE="${QUEUE:-Brother_HL_1110_series}"
BRIDGE_URL="https://raw.githubusercontent.com/sapireli/AirPrint_Bridge/a0f42bf1bd85387409edb6bea070d637d09051f3/airprint_bridge.sh"
BRIDGE_PATH="/usr/local/bin/airprint-bridge"

usage() {
  echo "Usage: $0 [--queue QUEUE_NAME]"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --queue)
      [ "$#" -ge 2 ] || { usage >&2; exit 2; }
      QUEUE="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      usage >&2
      exit 2
      ;;
  esac
done

command -v cupsctl >/dev/null || { echo "cupsctl is required." >&2; exit 1; }
command -v lpadmin >/dev/null || { echo "lpadmin is required." >&2; exit 1; }
command -v curl >/dev/null || { echo "curl is required." >&2; exit 1; }

if ! lpstat -p "$QUEUE" >/dev/null 2>&1; then
  echo "CUPS queue not found: $QUEUE" >&2
  echo "Run 'lpstat -p' and repeat with --queue <name>." >&2
  exit 1
fi

sudo cupsctl --share-printers
sudo lpadmin -p "$QUEUE" -o printer-is-shared=true

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
curl --fail --silent --show-error --location "$BRIDGE_URL" -o "$tmp"
bash -n "$tmp"

sudo install -m 0755 "$tmp" "$BRIDGE_PATH"
sudo "$BRIDGE_PATH" -i

echo "AirPrint bridge installed for CUPS queue: $QUEUE"
echo "Test from iPhone/iPad: Files > Share > Print."
