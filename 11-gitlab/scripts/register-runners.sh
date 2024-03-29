#!/bin/bash

gitlab-runner register \
  --non-interactive \
  --url "${1}" \
  --registration-token "${2}" \
  --executor "docker" \
  --docker-image alpine:latest \
  --description "docker-runner" \
  --maintenance-note "Free-form maintainer notes about this runner" \
  --tag-list "docker,${3}" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"

gitlab-runner run  