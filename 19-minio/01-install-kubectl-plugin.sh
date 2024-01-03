#!/bin/bash

curl https://github.com/minio/operator/releases/download/v5.0.11/kubectl-minio_5.0.11_linux_amd64 -o kubectl-minio
chmod +x kubectl-minio
mv kubectl-minio /usr/local/bin/