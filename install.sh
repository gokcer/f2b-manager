#!/usr/bin/env bash
#
# f2b-manager installer
#

set -euo pipefail

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="f2b-manager"
REPO_URL="https://raw.githubusercontent.com/gokcer/f2b-manager/main/f2b-manager"

# Detect if running from a local clone or piped via curl/wget
SOURCE_DIR=""
SELF="$0"
if [[ "$SELF" != "bash" && "$SELF" != "-bash" && "$SELF" != "/bin/bash" \
   && "$SELF" != "/usr/bin/bash" && "$SELF" != "sh" && "$SELF" != "/bin/sh" \
   && "$SELF" != "/dev/stdin" && "$SELF" != "/dev/fd/"* \
   && "$SELF" != "/proc/"* ]]; then
    REAL_DIR="$(cd "$(dirname "$SELF")" 2>/dev/null && pwd)"
    if [[ -n "$REAL_DIR" && -f "${REAL_DIR}/${SCRIPT_NAME}" ]]; then
        SOURCE_DIR="$REAL_DIR"
    fi
fi

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
if [[ -n "$SOURCE_DIR" && -f "${SOURCE_DIR}/${SCRIPT_NAME}" ]]; then
    install -m 755 "${SOURCE_DIR}/${SCRIPT_NAME}" "${INSTALL_DIR}/${SCRIPT_NAME}"
else
    info "Downloading ${SCRIPT_NAME} from GitHub..."
    curl -fsSL "$REPO_URL" -o "${INSTALL_DIR}/${SCRIPT_NAME}" \
        || error "Failed to download ${SCRIPT_NAME} from GitHub"
    chmod 755 "${INSTALL_DIR}/${SCRIPT_NAME}"
fi
info "Installed to ${INSTALL_DIR}/${SCRIPT_NAME}"

echo ""
info "Done! Run with: sudo f2b-manager"
echo ""
