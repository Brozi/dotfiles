#!/usr/bin/env bash
set -Eeuo pipefail

command -v git >/dev/null ||
  {
    echo "Cannot bootstrap Oh My Zsh: install git, then rerun chezmoi apply." >&2
    exit 1
  }

omz_dir="$HOME/.oh-my-zsh"
custom_dir="$omz_dir/custom/plugins"

install_repo() {
  local repository="$1"
  local destination="$2"

  if [[ -d "$destination/.git" ]]; then
    echo "Keeping existing checkout: $destination"
    return
  fi

  if [[ -e "$destination" ]]; then
    echo "Refusing to replace non-Git path: $destination" >&2
    exit 1
  fi

  mkdir -p "$(dirname "$destination")"
  git clone --depth 1 "https://github.com/${repository}.git" "$destination"
}

install_repo "ohmyzsh/ohmyzsh" "$omz_dir"

install_repo "zsh-users/zsh-autosuggestions" \
  "$custom_dir/zsh-autosuggestions"

install_repo "zsh-users/zsh-completions" \
  "$custom_dir/zsh-completions"

install_repo "jeffreytse/zsh-vi-mode" \
  "$custom_dir/zsh-vi-mode"

install_repo "Aloxaf/fzf-tab" \
  "$custom_dir/fzf-tab"

install_repo "zsh-users/zsh-syntax-highlighting" \
  "$custom_dir/zsh-syntax-highlighting"

install_repo "catppuccin/zsh-syntax-highlighting" \
  "$custom_dir/catppuccin-zsh-syntax-highlighting"

echo "Oh My Zsh and plugins are ready."
echo "Install zsh manually, then run chsh if you want Zsh as your login shell."
