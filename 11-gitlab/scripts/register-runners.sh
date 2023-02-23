#!/bin/bash

gitlab-runner register \
  --non-interactive \
  --url "${GITLAB_URL}" \
  --registration-token $REGISTRATION_TOKEN \
  --executor "docker" \
  --docker-image alpine:latest \
  --description "docker-runner" \
  --maintenance-note "Free-form maintainer notes about this runner" \
  --tag-list "docker" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"