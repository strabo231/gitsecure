#!/bin/bash

set -e

INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="gitsecure"
REPO_URL="https://raw.githubusercontent.com/strabo231/gitsecure/main/gitsecure"

echo "🔐 GitSecure Installer"
echo "====================="
echo ""

if [ "$EUID" -eq 0 ]; then
    INSTALL_DIR="/usr/local/bin"
elif [ -w "$INSTALL_DIR" ]; then
    echo "Installing to $INSTALL_DIR"
else
    INSTALL_DIR="$HOME/.local/bin"
    echo "Installing to $INSTALL_DIR"
    mkdir -p "$INSTALL_DIR"
fi

echo "Downloading gitsecure..."
if command -v curl &> /dev/null; then
    curl -sSL "$REPO_URL" -o "/tmp/$SCRIPT_NAME"
elif command -v wget &> /dev/null; then
    wget -q "$REPO_URL" -O "/tmp/$SCRIPT_NAME"
else
    echo "Error: curl or wget required"
    exit 1
fi

chmod +x "/tmp/$SCRIPT_NAME"

if [ -w "$INSTALL_DIR" ]; then
    mv "/tmp/$SCRIPT_NAME" "$INSTALL_DIR/$SCRIPT_NAME"
else
    sudo mv "/tmp/$SCRIPT_NAME" "$INSTALL_DIR/$SCRIPT_NAME"
fi

echo "✓ GitSecure installed!"
echo ""
echo "Protect your repo:"
echo "  gitsecure install-hook"
echo "  gitsecure protect"
