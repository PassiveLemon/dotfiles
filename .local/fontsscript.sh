#!/usr/bin/env bash

if [ $EUID = 0 ]; then
  echo "====================================="
  echo "Please do not run this script as Sudo"
  echo "====================================="
  exit
fi

sudo mkdir $HOME/lemontemp/
pushd $HOME/lemontemp/

sudo apt install -y curl unzip

mkdir -p $HOME/.local/share/fonts/

curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Iosevka.zip
mkdir -p $HOME/.local/share/fonts/Iosevka/
unzip Iosevka.zip -d $HOME/.local/share/fonts/Iosevka/

sudo rm -r $HOME/lemontemp/
popd