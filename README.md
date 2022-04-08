# Base system with the following running
- traefik
- elasticsearch
- kibana
- postgres database
- anaconda 
- portainer

---
## 1. Run proxy as a reverse proxy
> *sudo docker-compose -f 01-traefik-reverseproxy.yaml up --scale whoami=2 -d*

---
## 2. Elasticsearrch

To reset password for elastic user

> *docker exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic*

To generate enrollment token for kibana

> *docker exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token --scope kibana*

To verify the enrollment for kibana
> *docker exec -it kibana /usr/share/kibana/bin/kibana-verification-code*

To grab the cert out for other comms
> *docker cp es01:/usr/share/elasticsearch/config/certs/http_ca.crt .*

---
## 3. Postgresql database
*Persistency is not there yet*

[Reference](https://towardsdatascience.com/local-development-set-up-of-postgresql-with-docker-c022632f13ea)

## 4. Anaconda

## 5. Portainer


