#!/usr/bin/env bash
set -euo pipefail

[[ $EUID -eq 0 ]] || { echo "Please run as root: sudo ./uninstall.sh"; exit 1; }

rm -f /usr/local/bin/f2b-manager
echo "f2b-manager has been removed."
