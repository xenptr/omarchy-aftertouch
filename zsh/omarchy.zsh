# Omarchy Bash feature layer for Zsh.
#
# Omarchy owns and updates /usr/share/omarchy/default/bash.  Its aliases,
# environment and functions are currently Zsh-parseable, so load those files
# directly instead of carrying a stale copy from the archived Omadots project.
# The Zsh-only completion, keybindings and fzf widgets remain supplied by the
# installed omarchy-zsh package.

[[ -o interactive ]] || return 0

if [[ ! -r /usr/share/omarchy-zsh/shell/zoptions ]]; then
  print -u2 'omarchy-zsh is not installed; run ~/omarchy-aftertouch/install-zsh.sh'
  return 0
fi

# Zsh-native behaviour which Omarchy's Bash files cannot provide.
source /usr/share/omarchy-zsh/shell/zoptions

# This establishes OMARCHY_PATH and the package-installed fallback before the
# current Omarchy files are read.
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && \
  source /usr/share/omarchy/default/bash/env-bootstrap
: "${OMARCHY_PATH:=/usr/share/omarchy}"

# Deliberately do not source Bash's shell/init/completions files: they use
# Readline/Bash APIs.  `zoptions` and `inits` above/below are their Zsh-native
# counterparts.  The remaining files currently pass `zsh -n`; the post-update
# audit warns us if upstream changes that contract.
for _omarchy_zsh_file in envs aliases functions; do
  _omarchy_zsh_path="$OMARCHY_PATH/default/bash/${_omarchy_zsh_file}"
  [[ -r $_omarchy_zsh_path ]] && source "$_omarchy_zsh_path"
done
unset _omarchy_zsh_file _omarchy_zsh_path

# Tool integrations must be initialized for Zsh, not Bash.
source /usr/share/omarchy-zsh/shell/inits
