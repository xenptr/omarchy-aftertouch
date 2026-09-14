#!/usr/bin/env bash
# Keep personal aftertouch files layered over Omarchy-managed configs.
# Safe to run repeatedly; Omarchy calls it after every `omarchy update`.
set -euo pipefail

hypr_config="$HOME/.config/hypr/hyprland.lua"
tmux_config="$HOME/.config/tmux/tmux.conf"
hypr_loader='require("hypr.hyprland-override")'
tmux_loader="source-file $HOME/omarchy-aftertouch/tmux.local.conf"

ensure_line() {
  local file=$1 line=$2
  [[ -f $file ]] || return 0
  grep -Fqx -- "$line" "$file" || printf '\n%s\n' "$line" >>"$file"
}

ensure_line "$hypr_config" "$hypr_loader"
ensure_line "$tmux_config" "$tmux_loader"

# Apply the restored Tmux layer to existing servers without failing an update
# when no Tmux server is running.
tmux has-session 2>/dev/null && tmux source-file "$tmux_config" || true

# Omarchy updates can change the Bash feature files our Zsh layer consumes.
# This only reports compatibility; it never changes Omarchy-managed files.
"$HOME/omarchy-aftertouch/zsh/audit-current-omarchy-bash.sh" || true
