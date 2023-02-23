#!/bin/bash

# Arguements list: <container name> <external_url> <registration_token>
# Example: ./register.sh runner-7 10.0.0.7 xxxxxxxxxxx

if (($# < 1)) 
then
    echo "Number of arguements should be at least 2, getting " 
fi

yaml_file=run-${1}-compose.yml

cat <<EOF > $yaml_file
version: '3.6'
services:
  runner:
    image: 'gitlab/gitlab-runner:latest'
    container_name: ${1}
    restart: always
    hostname: '${2}'
    environment:
      REGISTRATION_TOKEN: ${3}   
    entrypoint: |
        sh -c "/scripts/register-runners.sh http://${2} ${3} ${1}" 
    volumes:
      - '$GITLAB_HOME/gitlab-runner/config:/etc/gitlab-runner'
      - /var/run/docker.sock:/var/run/docker.sock 
      - ./scripts:/scripts
EOF

sudo docker compose -f $yaml_file up -d
