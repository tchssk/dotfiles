#!/bin/bash

pushd `dirname $0`

# Dotfiles
for dotfile in .?*
do
  if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitmodules' ] && [ $dotfile != '.gitignore' ] && [ $dotfile != 'README.md' ];
  then
    ln -Fs "$PWD/$dotfile" $HOME
  fi
done

popd

# Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap Homebrew/brewdler
brew brewdle

# Git
git submodule init
git submodule update

# tmux
if [ -d ~/.tmux/plugins/tpm ];
then
  pushd ~/.tmux/plugins/tpm
  git pull
  popd
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# pip
pip install -r requirements.txt
