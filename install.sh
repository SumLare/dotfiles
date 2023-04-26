#!/bin/bash

dir="$HOME/dotfiles"
cd $dir

files="gitconfig zpreztorc zshrc vimrc"
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done

# Homebrew
echo "Installing Homebrew and Cask..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/artyomanokhin/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install caks
brew tap homebrew/cask

# Brew install
echo "Installing with brew..."
brew update
brew install git
brew install zsh
brew install node
brew install docker
brew install neovim

# Install apps with Cask
echo "Installing apps with Cask..."
brew cask install iterm2
brew cask install google-chrome

# TODO: Install powerline
