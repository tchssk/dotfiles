#!/bin/bash

cd `dirname $0`

# Dotfiles
for dotfile in .?*
do
  if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitmodules' ] && [ $dotfile != '.gitignore' ] && [ $dotfile != 'README.md' ];
  then
    ln -Fis "$PWD/$dotfile" $HOME
  fi
done

# Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap Homebrew/brewdler
brew brewdle

# Git
git submodule init
git submodule update
