#!/bin/bash
# Vivaldi Mods Uninstaller for macOS
# Removes injected script tags and deletes mods folder

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

echo "Found Vivaldi version: $VERSION"

# Check if Vivaldi is running
if pgrep -x "Vivaldi" > /dev/null; then
    echo "Error: Please quit Vivaldi before running this script"
    exit 1
fi

# Remove script tag from window.html
if grep -q "dashboard-widget-titles.js" "$WINDOW_HTML"; then
    # Remove the script tag line
    sed -i '' '/dashboard-widget-titles\.js/d' "$WINDOW_HTML"
    echo "Removed script tag from window.html"
else
    echo "No script tag found in window.html, skipping..."
fi

# Remove mods directory if it exists
if [ -d "$MODS_DIR" ]; then
    rm -rf "$MODS_DIR"
    echo "Removed mods directory: $MODS_DIR"
else
    echo "No mods directory found, skipping..."
fi

# Remove backup if it exists
if [ -f "$WINDOW_HTML.backup" ]; then
    rm "$WINDOW_HTML.backup"
    echo "Removed backup file: $WINDOW_HTML.backup"
fi

echo ""
echo "Uninstall complete! You can now launch Vivaldi."
