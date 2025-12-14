#!/bin/bash
# Vivaldi Mods Installer for macOS
# Run this script after each Vivaldi update to re-install mods

set -e

# Find the Vivaldi version directory
VIVALDI_BASE="/Applications/Vivaldi.app/Contents/Frameworks/Vivaldi Framework.framework/Versions"
VERSION=$(ls "$VIVALDI_BASE" | grep -E '^[0-9]+\.' | head -1)

if [ -z "$VERSION" ]; then
    echo "Error: Could not find Vivaldi version directory"
    exit 1
fi

VIVALDI_RESOURCES="$VIVALDI_BASE/$VERSION/Resources/vivaldi"
WINDOW_HTML="$VIVALDI_RESOURCES/window.html"
MODS_DIR="$VIVALDI_RESOURCES/mods"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Found Vivaldi version: $VERSION"
echo "Installing mods to: $MODS_DIR"

# Check if Vivaldi is running
if pgrep -x "Vivaldi" > /dev/null; then
    echo "Error: Please quit Vivaldi before running this script"
    exit 1
fi

# Create mods directory
mkdir -p "$MODS_DIR"

# Copy mod files
cp "$SCRIPT_DIR/mods/"*.js "$MODS_DIR/"
echo "Copied mod files to $MODS_DIR"

# Check if window.html already has our script tag
if grep -q "dashboard-widget-titles.js" "$WINDOW_HTML"; then
    echo "window.html already contains script tag, skipping..."
else
    # Backup window.html
    cp "$WINDOW_HTML" "$WINDOW_HTML.backup"
    echo "Created backup: $WINDOW_HTML.backup"

    # Inject script tag before </body>
    sed -i '' 's|</body>|  <script src="mods/dashboard-widget-titles.js"></script>\n</body>|' "$WINDOW_HTML"
    echo "Injected script tag into window.html"
fi

echo ""
echo "Installation complete! You can now launch Vivaldi."
