#!/usr/bin/env bash

if ! command -v zsh &>/dev/null; then
    yay -S --needed --noconfirm zsh
fi

"$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/install-omarchy-zsh-overlay.sh"
