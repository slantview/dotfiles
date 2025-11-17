#!/bin/bash
# Install Spicetify and set up rudo theme

set -e

echo "=== Installing Spicetify ==="

# Check if already installed
if command -v spicetify >/dev/null 2>&1; then
    echo "✓ Spicetify is already installed"
    spicetify --version
else
    # Try to install via AUR helper
    if command -v yay >/dev/null 2>&1; then
        echo "Installing via yay..."
        yay -S spicetify-cli
    elif command -v paru >/dev/null 2>&1; then
        echo "Installing via paru..."
        paru -S spicetify-cli
    else
        echo "No AUR helper found. Installing from source..."
        curl -fsSL https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
    fi
fi

echo ""
echo "=== Linking rudo theme ==="
cd "$(dirname "$0")"
make spicetify-theme

echo ""
echo "=== Applying theme ==="
spicetify backup apply
spicetify config current_theme rudo
spicetify config color_scheme rudo

# Check if we need sudo for applying
if [ ! -w /opt/spotify/Apps ] 2>/dev/null; then
    echo ""
    echo "⚠ Permission issue detected. Applying theme with sudo..."
    sudo spicetify apply
else
    spicetify apply
fi

echo ""
echo "✓ Spicetify theme installed and applied!"
echo "  Restart Spotify to see the changes."

