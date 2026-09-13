#!/bin/bash
set -euo pipefail

QUEUE="${QUEUE:-Brother_HL_1110_series}"

echo "== CUPS queue =="
lpstat -p "$QUEUE" -d 2>&1 || true
lpstat -o "$QUEUE" 2>&1 || true

echo
echo "== AirPrint bridge =="
ps aux | grep -E '[a]irprint_bridge|[d]ns-sd -R' || true
launchctl list | grep -i airprint || true

echo
echo "== Bonjour services =="
echo "Run 'dns-sd -B _ipp._tcp local' to browse without stopping the command."

echo
echo "== Recent CUPS errors =="
tail -n 40 /var/log/cups/error_log 2>/dev/null || true
