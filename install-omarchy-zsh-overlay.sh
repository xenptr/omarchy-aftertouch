#!/usr/bin/env bash
# Install our user-owned Zsh layer over current Omarchy Bash features.
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
zshrc="$HOME/.zshrc"
marker='# omarchy-aftertouch: current Omarchy feature layer'
loader="source \"$script_dir/zsh/omarchy.zsh\""

if ! pacman -Q omarchy-zsh >/dev/null 2>&1; then
  echo "Installing omarchy-zsh for its Zsh-only completion and widgets..."
  yay -S --needed --noconfirm omarchy-zsh
fi

touch "$zshrc"
if ! grep -Fqx -- "$marker" "$zshrc"; then
  printf '\n%s\n%s\n' "$marker" "$loader" >> "$zshrc"
fi

chmod +x "$script_dir/zsh/audit-current-omarchy-bash.sh"
"$script_dir/zsh/audit-current-omarchy-bash.sh"
echo "Installed current Omarchy feature layer for Zsh. Start a new terminal."
