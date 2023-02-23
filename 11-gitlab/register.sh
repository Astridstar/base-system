#!/bin/bash

if (($# < 1)) 
then
    echo "Number of arguements should be at least 2, getting " 
fi

REGISTRATION_TOKEN=${GITLAB_RUNNER_REGISTRATION_TOKEN}

cat <<EOF > register-compose.yml
version: '3.6'
services:
  runner:
    image: 'gitlab/gitlab-runner:latest'
    container_name: ${1}
    restart: always
    hostname: '10.0.0.7'
    environment:
      REGISTRATION_TOKEN: $REGISTRATION_TOKEN   
    entrypoint: |
        sh -c "/scripts/register-runners.sh http://10.0.0.7 $REGISTRATION_TOKEN" 
    volumes:
      - '$GITLAB_HOME/gitlab-runner/config:/etc/gitlab-runner'
      - ./scripts:/scripts
EOF

sudo docker compose -f register-compose.yml up -d

# version: '3.6'
# services:
#   runner:
#     image: 'gitlab/gitlab-runner:latest'
#     container_name: ${1}
#     restart: always
#     hostname: '10.0.0.7'
#     # env_file:
#     #   - .env    
#     environment:
#       REGISTRATION_TOKEN: |
#         $REGISTRATION_TOKEN   
#     command: |
#       /bin/bash -c '/scripts/register-runner.sh  \"http://10.0.0.7\" $REGISTRATION_TOKEN'
#     volumes:
#       - '$GITLAB_HOME/gitlab-runner/config:/etc/gitlab-runner'
#       - ./scripts:/scripts