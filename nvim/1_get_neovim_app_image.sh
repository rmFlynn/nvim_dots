#!/bin/bash

# You dont need to run this if you installed neovim in a normal whay

# you can ge the version here
VERSION=v0.8.2

mkdir appimage
cd appimage
wget https://github.com/neovim/neovim/releases/download/$VERSION/nvim.appimage
chmod +x nvim.appimage
./nvim.appimage --appimage-extract

cd ..
VIMPATH=$(realpath ./appimage/squashfs-root/usr/bin/nvim)
mkdir -p $HOME/bin
ln -sf $VIMPATH $HOME/bin/nvim

TEXTTOPROFILE='export PATH="$HOME/bin:$PATH"'
 grep "$TEXTTOPROFILE"  $HOME/.bash_profile || echo $TEXTTOPROFILE >> $HOME/.bash_profile

