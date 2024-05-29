#!/bin/zsh

VM_NAME=${1:-"dev-svr-1"}

/usr/local/bin/multipass delete $VM_NAME
/usr/local/bin/multipass purge
/usr/bin/ssh-keygen -R $(pwd)/$VM_NAME-id_rsa