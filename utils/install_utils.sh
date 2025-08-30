#!/bin/zsh

set -e

brew_packages=(
  "watch"
  "wget"
  "wdiff"

  "coreutils"
  "binutils"
  "diffutils"
  "ed"
  "findutils"
  "gawk"
  "gnu-indent"
  "gnu-sed"
  "gnu-tar"
  "gnu-which"
  "grep"
  "gzip"

  "gpatch"
  "less"
  "m4"
  "make"
  "bison"
  "flex"

  "libressl"
  "file-formula"
  "git"
  "openssh"
  "rsync"
  "unzip"
  "vim"

  "python"
)

  # Ensure a Homebrew package is installed
ensure_brew() {
  if [[ -z "$1" ]]; then
    echo "Usage: ensure_brew <package>"
    return 1
  fi

  local pkg="$1"

  if brew list --formula --cask "$pkg" &>/dev/null; then
    echo "✅ $pkg is already installed."
  else
    echo "📦 Installing $pkg..."
    if brew install "$pkg"; then
      echo "✅ Successfully installed $pkg."
    else
      echo "❌ Failed to install $pkg."
      return 1
    fi
  fi
}

for pkg in "${brew_packages[@]}"; do
  ensure_brew "$pkg"
done
