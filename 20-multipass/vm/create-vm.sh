#!/bin/bash

SHARED_DIR=${1:-"./shared_dir"}
SVR_NAME=${2:-"dev-svr-1"}

if [ -d $SHARED_DIR ]; then
    rm -rf $SHARED_DIR
    mkdir -p $SHARED_DIR
else
    mkdir -p $SHARED_DIR
fi

# generate the ssh keys
ssh-keygen -q -t rsa -N '' -f $(pwd)/$SVR_NAME-id_rsa <<<y >/dev/null 2>&1
echo $?

# run the multipass commands
multipass launch -n $SVR_NAME \
    --cpus 4 --disk 150G --memory 8G \
    --mount $SHARED_DIR:/home/ubuntu/shared_dir \
    --cloud-init ./cloud-config.yaml

# check IP addresses
IP=$(multipass info $SVR_NAME | grep "IPv4" | awk '{ print $2  }')
echo IP address = $IP

# shell into the VM
/usr/bin/ssh -i "$(pwd)/$SVR_NAME-id_rsa"  ubuntu@$IP

