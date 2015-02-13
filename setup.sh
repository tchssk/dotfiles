#!/bin/bash

cd `dirname $0`

# Dotfiles
for dotfile in .?*
do
  if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitmodules' ] && [ $dotfile!= '.gitignore' ] && [ $dotfile != 'README.md' ]
  then
    ln -Fis "$PWD/$dotfile" $HOME
  fi
done

# Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install brew-cask
brew install git
brew install scala
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install macvim-kaoriya
brew cask install vlc
