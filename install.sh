#!/usr/bin/env bash
#
# f2b-manager installer
#

set -euo pipefail

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="f2b-manager"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[+]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[x]${NC} $1"; exit 1; }

[[ $EUID -eq 0 ]] || error "Please run as root: sudo ./install.sh"

echo ""
echo "  ╔═══════════════════════════════════╗"
echo "  ║     f2b-manager — Installer       ║"
echo "  ╚═══════════════════════════════════╝"
echo ""

# Check dependencies
for cmd in dialog fail2ban-client; do
    if ! command -v "$cmd" &>/dev/null; then
        warn "'$cmd' not found. Attempting to install..."
        if command -v apt-get &>/dev/null; then
            apt-get install -y "$cmd" || error "Failed to install $cmd"
        elif command -v dnf &>/dev/null; then
            dnf install -y "$cmd" || error "Failed to install $cmd"
        elif command -v yum &>/dev/null; then
            yum install -y "$cmd" || error "Failed to install $cmd"
        elif command -v pacman &>/dev/null; then
            pacman -S --noconfirm "$cmd" || error "Failed to install $cmd"
        else
            error "Cannot auto-install '$cmd'. Please install it manually."
        fi
    fi
    info "$cmd found: $(command -v "$cmd")"
done

# Install
install -m 755 "${SOURCE_DIR}/${SCRIPT_NAME}" "${INSTALL_DIR}/${SCRIPT_NAME}"
info "Installed to ${INSTALL_DIR}/${SCRIPT_NAME}"

echo ""
info "Done! Run with: sudo f2b-manager"
echo ""
