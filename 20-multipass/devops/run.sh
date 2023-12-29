#!/bin/bash

SERVER_NAME=$1
HOST_DATA_DIR=$HOME/storage/multipass/$SERVER_NAME

INSTANCE_DATA_DIR=/shared_data
INSTANCE_SCRIPTS_DIR=/shared_data/scripts
GITHUB_PAT_DATA=/shared_data/github_pat.txt

if [ ! -d $HOST_DATA_DIR ] 
then
  mkdir -p $HOST_DATA_DIR
fi

echo ==== Launch $SERVER_NAME instance ====
multipass launch -n $SERVER_NAME -c 4 -m 16G --disk 300G --cloud-init ./cloud-config-k8s.yaml --timeout 600 --mount $HOST_DATA_DIR:$INSTANCE_DATA_DIR

echo ==== Setting up Github pat ====
multipass exec -n $SERVER_NAME -- sudo bash -c "cat << EOF >> $GITHUB_PAT_DATA
echo $GITHUB_PAT | base64 
EOF"

echo ==== Setting up instance name ====
multipass exec -n $SERVER_NAME -- sudo bash -c "cat << EOF >> $GITHUB_PAT_DATA
echo $GITHUB_PAT | base64 
EOF"

echo ==== Setting up git parameters ====
username=$( git config --global user.name  )
useremail=$( git config --global user.email )
defaultbranch=$( git config --global init.defaultBranch )
echo
multipass exec $SERVER_NAME -- git config --global user.name "$username"
multipass exec $SERVER_NAME -- git config --global user.email "$useremail"
multipass exec $SERVER_NAME -- git config --global user.defaultBranch "$defaultbranch"
echo

echo ==== Transfer scripts to $SERVER_NAME ====
sudo multipass transfer -r -p ./scripts $SERVER_NAME:$INSTANCE_SCRIPTS_DIR
echo
echo ==== Executing installation scripts on instance ====
multipass exec $SERVER_NAME -- chmod +x $INSTANCE_SCRIPTS_DIR/install.sh
multipass exec $SERVER_NAME -- sudo bash -c $INSTANCE_SCRIPTS_DIR/install.sh
echo

echo ==== Enabling minikube port-forwarding ====
cd ./scripts/port-forwarding
nohup ./forward-portainer-agent.sh $SERVER_NAME & > portainer-agent.sh.log
nohup ./forward-argocd-ui.sh $SERVER_NAME & > argocd-ui.sh.log

#echo ==== Launching instance shell ====
#multipass shell $SERVER_NAME
#echo
