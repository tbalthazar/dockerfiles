#!/bin/bash

target=/tmp/alacritty-target
mnt=/mnt/alacritty
mkdir -p $target

image=tbalthazar/alacritty-builder
docker pull $image
docker run \
  --rm \
  -v $target:$mnt \
  $image

# Terminfo - `infocmp alacritty` to confirm it worked
sudo tic -xe alacritty,alacritty-direct $target/alacritty.info

# Desktop entry
sudo cp $target/alacritty /usr/local/bin
sudo cp $target/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install $target/Alacritty.desktop
sudo update-desktop-database
