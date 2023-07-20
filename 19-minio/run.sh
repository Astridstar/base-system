#!/bin/bash

# System
MINIO_ROOT_USER=$(< /dev/urandom tr -dc a-z | head -c${1:-4})
MINIO_ROOT_PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-8})
MINIO_PORT="9010"

# Start the container
# sudo docker run -it -d --rm \
#    -v ~/.minio-data/:/data \
#    --name minio-local \
#    -p ${MINIO_PORT}:${MINIO_PORT} \
#    -e MINIO_ROOT_USER=${MINIO_ROOT_USER} \
#    -e  MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD} \
#    minio/minio  server /data --address :${MINIO_PORT}
sudo docker run -it -d --rm \
   -v ~/.minio-data/:/data \
   --name minio-local \
   -p ${MINIO_PORT}:9000 \
   -e MINIO_ROOT_USER=${MINIO_ROOT_USER} \
   -e  MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD} \
   minio/minio  server /data --address :${MINIO_PORT}

# This information is used in next {.1}

echo "
MINIO_ROOT_USER=${MINIO_ROOT_USER}
MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD}
ENDPOINT=http://$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' minio-local):${MINIO_PORT}
"
####
# MINIO_ROOT_PASSWORD=CHANGEME123
# MINIO_ROOT_USER=admin
# ENDPOINT=http://127.0.0.1:9000

# echo ${MINIO_ROOT_PASSWORD} | hal config storage s3 edit --endpoint $ENDPOINT \
#     --access-key-id ${MINIO_ROOT_USER} \
#     --secret-access-key