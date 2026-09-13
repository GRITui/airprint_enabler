#!/bin/bash
set -euo pipefail

if [ -x /usr/local/bin/airprint-bridge ]; then
  sudo /usr/local/bin/airprint-bridge -u || true
fi

sudo cupsctl --no-share-printers
echo "AirPrint bridge removed. The printer and Brother driver were left installed."
