#!/bin/bash

# System
MINIO_ROOT_USER=minio-admin
MINIO_ROOT_PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-12})
MINIO_PORT="9010"

cat << EOF >> initial-password.txt
echo $MINIO_ROOT_PASSWORD | base64 
EOF

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

cat << EOF >> initial-information.txt
echo MINIO_ROOT_USER=${MINIO_ROOT_USER}
echo MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD}
echo ENDPOINT=http://$( sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' minio-local ):${MINIO_PORT}
EOF