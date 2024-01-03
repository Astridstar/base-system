#!/bin/bash

if [ -z "$1" ]
  then
    echo "No argument supplied for host path"
    exit
fi

# System
MINIO_ROOT_USER=minio-admin
MINIO_ROOT_PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-12})
MINIO_PORT="9010"

cat << EOF >> initial-password.txt
echo $MINIO_ROOT_PASSWORD | base64 
EOF

sudo docker run -it -d --rm \
   --name minio-local \
   -v $1:/mnt/data  \
   -p ${MINIO_PORT}:9000 -p 9001:9001    \
   -e MINIO_ROOT_USER=${MINIO_ROOT_USER} \
   -e MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD} \
   minio/minio  server /data --address :${MINIO_PORT}


# docker run -dt                                  \
#   -p 9000:9000 -p 9001:9001                     \
#   -v PATH:/mnt/data                             \
#   -v ./config.env:/etc/config.env         \
#   -e "MINIO_CONFIG_ENV_FILE=/etc/config.env"    \
#   --name "minio_local"                          \
#   minio server --console-address ":9001"




# This information is used in next {.1}

cat << EOF >> initial-information.txt
echo MINIO_ROOT_USER=${MINIO_ROOT_USER}
echo MINIO_ROOT_PASSWORD=${MINIO_ROOT_PASSWORD}
echo ENDPOINT=http://$( sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' minio-local ):${MINIO_PORT}
EOF