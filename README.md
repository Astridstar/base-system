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


## 9. Tigergraph

### 9.1 Run Tigergraph Docker image as daemon

[Run Tigergraph Docker image as daemon](https://docs-legacy.tigergraph.com/start/get-started/docker#4.-use-ssh-to-connect-to-your-container)
> *docker run -d -p 14022:22 -p 9000:9000 -p 14240:14240 --name tigergraph --ulimit nofile=1000000:1000000 -v ~/data:/home/tigergraph/mydata -t docker.tigergraph.com/tigergraph:latest

### 9.2 Use SSH to connect to the container
After launching the container, you can use SSH to connect to your container:
Verify that the container is running. You should see a row that describes the running container after running the command below:

> docker ps | grep tigergraph

Use ssh to open a shell to the container. At the prompt, enter tigergraph  as the password. Note that we have mapped the host 14022 port to the container's 22 port (the ssh default port), so on the host we use ssh to connect to port 14022. 
> ssh -p 14022 tigergraph@localhost

### 9.3 Start TigerGraph
1. After connecting to the container via ssh, inside the container, start all TigerGraph services with the following command (which may take up to one minute):
> gadmin start all

2. Run the gsql command as shown below to start the GSQL shell. If you are new to TigerGraph, you can run the GSQL 101 tutorial now.
> $ gsql
> GSQL > 

3. Start GraphStudio, TigerGraph's visual IDE, by visiting http://localhost:14240
in a browser on your laptop (host OS).


