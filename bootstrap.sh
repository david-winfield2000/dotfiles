#!/usr/bin/env bash
# Copy dotfiles from this repo to the home directory, replacing system files.
# Existing files are backed up with a .bak suffix.
# Run from the .dotfiles directory: ./bootstrap.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

copy_file() {
  local src="$1" dst="$2"
  if [ -e "$dst" ] && [ ! -e "${dst}.bak" ]; then
    echo "Backing up original $dst to ${dst}.bak"
    cp -p "$dst" "${dst}.bak"
  fi
  cp "$src" "$dst"
  echo "Copied $src -> $dst"
}

copy_dir() {
  local src="$1" dst="$2"
  if [ -e "$dst" ] && [ ! -e "${dst}.bak" ]; then
    echo "Backing up original $dst to ${dst}.bak"
    cp -r "$dst" "${dst}.bak"
  fi
  mkdir -p "$dst"
  cp -r "$src"/* "$dst"
  echo "Copied $src/* -> $dst"
}

echo "Dotfiles directory: $DOTFILES_DIR"

# Ensure submodules are initialized (e.g. nvim config)
if [ -d "$DOTFILES_DIR/.git" ]; then
  echo "Initializing git submodules..."
  git -C "$DOTFILES_DIR" submodule update --init --recursive
fi

mkdir -p "$HOME/.config"

# Bash
copy_file "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
copy_file "$DOTFILES_DIR/bash/.bash_aliases" "$HOME/.bash_aliases"

# Zsh
copy_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Neovim
copy_dir "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Ghostty
copy_dir "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"

# Git
copy_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

# Tmux
copy_file "$DOTFILES_DIR/.tmux.config" "$HOME/.tmux.config"

echo "Done."
