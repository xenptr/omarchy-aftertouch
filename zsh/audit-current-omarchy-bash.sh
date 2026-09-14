#!/usr/bin/env bash
# Report when an Omarchy update changes a file consumed by zsh/omarchy.zsh.
# It never alters configuration and intentionally exits zero for update hooks.
set -uo pipefail

root="${OMARCHY_PATH:-/usr/share/omarchy}/default/bash"
baseline="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)/upstream-baseline.sha256"

if [[ ! -d $root || ! -r $baseline ]]; then
  echo "omarchy-zsh overlay audit skipped: Omarchy or baseline is unavailable" >&2
  exit 0
fi

changed=0
while read -r expected relative; do
  [[ -n ${expected:-} && -n ${relative:-} ]] || continue
  file="$root/$relative"
  if [[ ! -r $file ]]; then
    echo "omarchy-zsh overlay: upstream file disappeared: $relative" >&2
    changed=1
    continue
  fi
  actual=$(sha256sum "$file" | awk '{print $1}')
  if [[ $actual != "$expected" ]]; then
    echo "omarchy-zsh overlay: upstream changed: $relative" >&2
    changed=1
  fi
  if ! zsh -n "$file" >/dev/null 2>&1; then
    echo "omarchy-zsh overlay: no longer Zsh-parseable: $relative" >&2
    changed=1
  fi
done < "$baseline"

while IFS= read -r -d '' file; do
  relative=${file#"$root"/}
  grep -Fq " $relative" "$baseline" || {
    echo "omarchy-zsh overlay: new upstream function needs review: $relative" >&2
    changed=1
  }
done < <(find "$root/fns" -type f -print0 2>/dev/null)

if (( changed )); then
  echo "Review ~/omarchy-aftertouch/zsh/omarchy.zsh before relying on the changed feature." >&2
else
  echo "omarchy-zsh overlay: current Omarchy Bash feature layer is compatible."
fi
