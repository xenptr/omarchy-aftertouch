#!/usr/bin/env bash
set -e

yay -S --needed --noconfirm tmux

if ! command -v tmux &>/dev/null; then
  echo "tmux installation failed."
  exit 1
fi

TPM_DIR="$HOME/.tmux/plugins/tpm"

# --- Check if TPM is already installed ---
if [ -d "$TPM_DIR" ]; then
  echo "TPM is already installed in $TPM_DIR"
else
  echo "Installing Tmux Plugin Manager (TPM)..."
  git clone https://github.com/tmux-plugins/tpm $TPM_DIR
fi

echo "TPM installed successfully!"

# --- Config paths ---
TMUX_CONFIG="$HOME/.config/tmux/tmux.conf"   # Omarchy config
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_CONFIG="$SCRIPT_DIR/tmux.local.conf"
SOURCE_LINE="source-file $LOCAL_CONFIG"

echo "==> Setting up tmux local config..."

# --- Check if tmux config exists ---
if [ ! -f "$TMUX_CONFIG" ]; then
  echo "tmux config not found at $TMUX_CONFIG"
  echo "Make sure Omarchy tmux is installed"
  exit 1
fi

# --- Check if local config exists ---
if [ ! -f "$LOCAL_CONFIG" ]; then
  echo "Local config not found at $LOCAL_CONFIG"
  exit 1
fi

# --- Inject source line if not present ---
if grep -Fxq "$SOURCE_LINE" "$TMUX_CONFIG"; then
  echo "tmux.local.conf already sourced"
else
  echo "Adding source line to tmux config..."
  printf "\n%s\n" "$SOURCE_LINE" >> "$TMUX_CONFIG"
  echo "Source line added successfully"
fi

echo "==> tmux setup complete!"