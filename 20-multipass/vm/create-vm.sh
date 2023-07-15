#!/bin/zsh

if [ -d shared_dir ]; then
    rm -rf ./shared_dir
    mkdir ./shared_dir
elif then
    mkdir ./shared_dir
fi

VM_NAME=$1
/usr/local/bin/multipass launch -n $VM_NAME \
    --cpus 4 --disk 150G --memory 8G \
    --mount ./shared_dir:/home/ubuntu/shared_dir \
    --cloud-init ./cloud-config.yaml

IP=$(multipass info dev-svr-1 | grep "IPv4" | awk '{ print $2  }')
echo IP address = $IP

/usr/bin/ssh -i "$(pwd)/ssh-key"  ubuntu@$IP

