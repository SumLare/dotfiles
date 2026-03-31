#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "==> Dotfiles directory: $DOTFILES"

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Installing packages from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile"

# --- Symlink helper ---
link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "  Backing up existing $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "  $dst -> $src"
}

# --- Git ---
echo "==> Linking git config..."
link "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"
link "$DOTFILES/git/gitignore" "$HOME/.gitignore"

# --- Fish ---
echo "==> Linking fish config..."
link "$DOTFILES/fish/config.fish" "$HOME/.config/fish/config.fish"
link "$DOTFILES/fish/fish_plugins" "$HOME/.config/fish/fish_plugins"
mkdir -p "$HOME/.config/fish/conf.d"
for f in "$DOTFILES"/fish/conf.d/*.fish; do
  link "$f" "$HOME/.config/fish/conf.d/$(basename "$f")"
done

# --- Starship ---
echo "==> Linking starship config..."
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"

# --- Tmux ---
echo "==> Linking tmux config..."
link "$DOTFILES/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"

# Install tpm if not present
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "  Installing tmux plugin manager..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# --- Neovim ---
echo "==> Linking neovim config..."
link "$DOTFILES/nvim/init.lua" "$HOME/.config/nvim/init.lua"
link "$DOTFILES/nvim/lua" "$HOME/.config/nvim/lua"

# --- Fish shell & plugins ---
if command -v fish &>/dev/null; then
  echo "==> Setting fish as default shell..."
  FISH_PATH="$(which fish)"
  if ! grep -q "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
  fi
  if [ "$SHELL" != "$FISH_PATH" ]; then
    chsh -s "$FISH_PATH"
  fi

  echo "==> Installing fisher and fish plugins..."
  fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update'
fi

echo "==> Done! Restart your terminal."
