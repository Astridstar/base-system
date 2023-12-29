#!/bin/bash

CURR_PWD=$( pwd )

if [ ! -d $HOME/system ]
then
  mkdir $HOME/system
  cd $HOME/system
  git clone https://github.com/Astridstar/base-system.git
fi

cd $HOME/system

# Install portainer on docker
cd $HOME/system/base-system/06-portainer
chmod +x run-server
./run-server

chmod +x install-agent-nodeport
./install-agent-nodeport

# Install minio on docker
cd $HOME/system/base-system/19-minio
chmod +x run.sh
#./run.sh

cd $CURR_PWD
