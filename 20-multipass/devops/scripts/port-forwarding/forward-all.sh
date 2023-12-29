#!/bin/bash

nohup ./portainer-agent.sh devops-svr & > portainer-agent.sh.log
nohup ./argocd-ui.sh devops-svr & > argocd-ui.sh.log

