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
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install caks
brew tap caskroom/cask

# Brew install
echo "Installing with brew..."
brew update
brew install git
brew install zsh
brew install node
brew install postgresql
brew install docker

# Install apps with Cask
echo "Installing apps with Cask..."
brew cask install iterm2
brew cask install google-chrome

# TODO: Install powerline

# Ruby
rbenv install 2.5.1
gem install bundler mina
