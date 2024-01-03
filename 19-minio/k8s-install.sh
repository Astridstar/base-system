#!/bin/bash


helm repo add minio-operator https://operator.min.io

helm install \
  --namespace minio-operator \
  --create-namespace \
  operator minio-operator/operator

# Displaying all components in the minio-operator namespace
kubectl get all -n minio-operator

# Getting the node port used by MINIO
kubectl get svc/console -n minio-operator -o json | jq -r '.spec.ports'

