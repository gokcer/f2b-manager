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

# Check dialog
if ! command -v dialog &>/dev/null; then
    warn "'dialog' not found. Attempting to install..."
    if command -v apt-get &>/dev/null; then
        apt-get install -y dialog || error "Failed to install dialog"
    elif command -v dnf &>/dev/null; then
        dnf install -y dialog || error "Failed to install dialog"
    elif command -v yum &>/dev/null; then
        yum install -y dialog || error "Failed to install dialog"
    elif command -v pacman &>/dev/null; then
        pacman -S --noconfirm dialog || error "Failed to install dialog"
    else
        error "Cannot auto-install 'dialog'. Please install it manually."
    fi
fi
info "dialog found: $(command -v dialog)"

# Check fail2ban availability (native or Docker)
if command -v fail2ban-client &>/dev/null; then
    info "fail2ban-client found: $(command -v fail2ban-client)"
elif command -v docker &>/dev/null; then
    info "docker found — will use Docker-based fail2ban"
else
    warn "Neither fail2ban-client nor docker found on this host."
    warn "Install fail2ban or ensure a fail2ban Docker container is running."
fi

# Install
install -m 755 "${SOURCE_DIR}/${SCRIPT_NAME}" "${INSTALL_DIR}/${SCRIPT_NAME}"
info "Installed to ${INSTALL_DIR}/${SCRIPT_NAME}"

echo ""
info "Done! Run with: sudo f2b-manager"
echo ""
