#!/usr/bin/env bash
set -e

HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.lua"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OVERRIDES_CONFIG="$HOME/.config/hypr/hyprland-override.lua"
REPO_OVERRIDES_CONFIG="$SCRIPT_DIR/hyprland-override.lua"
SOURCE_LINE='require("hypr.hyprland-override")'

# --- Check if hyprland config exists ---
if [ ! -f "$HYPRLAND_CONFIG" ]; then
    echo "Hyprland config not found at $HYPRLAND_CONFIG"
    echo "Please install hyprland first"
    exit 1
fi

# --- Seed the personal override file once, without overwriting it later ---
if [ ! -f "$OVERRIDES_CONFIG" ]; then
    cp "$REPO_OVERRIDES_CONFIG" "$OVERRIDES_CONFIG"
fi

# --- Check if Lua override loader already exists ---
if grep -Fxq "$SOURCE_LINE" "$HYPRLAND_CONFIG"; then
    echo "Source line already exists in $HYPRLAND_CONFIG"
else
    echo "Adding source line to $HYPRLAND_CONFIG"
    echo "" >> "$HYPRLAND_CONFIG"
    echo "$SOURCE_LINE" >> "$HYPRLAND_CONFIG"
    echo "Source line added successfully"
fi

echo "Hyprland overrides setup complete!"
