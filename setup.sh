#!/bin/bash

cd `dirname $0`

for dotfile in .?*
do
  if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitmodules' ] && [ $dotfile!= '.gitignore' ] && [ $dotfile != 'README.md' ]
  then
    ln -Fis "$PWD/$dotfile" $HOME
  fi
done
