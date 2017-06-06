#!/bin/bash
# -*- ENCODING: UTF-8 -*-
  echo "deb http://ubuntu.kurento.org trusty-dev kms6" | sudo tee /etc/apt/sources.list.d/kurento-dev.list
  wget -O - http://ubuntu.kurento.org/kurento.gpg.key | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install $(cat debian/control | sed -e "s/$/\!\!/g" | tr -d '\n' | sed "s/\!\! / /g" | sed "s/\!\!/\n/g" | grep "Build-Depends" | sed "s/Build-Depends: //g" | sed "s/([^)]*)//g" | sed "s/, */ /g")
  mkdir -p build
  cd build
  cmake ..
  make -j4
sudo service kurento-media-server start
exit
