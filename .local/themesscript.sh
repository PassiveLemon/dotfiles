#!/usr/bin/env bash

if [ $EUID = 0 ]; then
  echo "====================================="
  echo "Please do not run this script as Sudo"
  echo "====================================="
  exit
fi

sudo mkdir $HOME/lemontemp/
sudo chmod 777 $HOME/lemontemp/
pushd $HOME/lemontemp/

mkdir -p $HOME/.local/share/themes/

curl -LO https://github.com/EliverLara/Nordic/releases/latest/download/Nordic-Polar-standard-buttons.tar.xz
sudo tar -xf Nordic-Polar-standard-buttons.tar.xz
cp -r $HOME/Nordic-Polar-standard-buttons/ $HOME/.local/share/themes/

popd
sudo rm -r $HOME/lemontemp/