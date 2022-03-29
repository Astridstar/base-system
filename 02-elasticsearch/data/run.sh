sudo docker-compose --env-file ./local.env -f docker-compose.yml up -d

# create the broker's key
keytool -keystore fleet.keystore.jks -storepass ESFleet -alias fleet --validity 5000 -keyalg RSA -genkey
# create a new certificate authority
openssl req -new -x509 -keyout ca-key -out ca-cert -days 5000

# add the CA to the kafka client's trust store
keytool -keystore fleet.truststore.jks -storepass ESFleet -alias CARoot -keyalg RSA -import -file ca-cert

# export the server certificate
keytool -keystore fleet.keystore.jks -storepass ESFleet -alias fleet -certreq -file fleet-cert

# sign it with the CA
openssl x509 -req -CA ca-cert -CAkey ca-key -in fleet-cert -out fleet-cert-signed -days 5000 -CA createserial -passin pass:ESFleet

# import CA and signed cert back into server keystore
keytool -keystore fleet.keystore.jks -storepass ESFleet -alias CARoot -import -file ca-cert
keytool -keystore fleet.keystore.jks -storepass ESFleet -alias fleet -import -file fleet-cert-signed


sudo docker run --name agent \
  --net elastic \
  --env FLEET_URL=https://fleet-server:8220 \
  --env FLEET_SERVER_ENABLE=true \
  --env FLEET_SERVER_ELASTICSEARCH_HOST=http://es01:9200 \
  --env FLEET_SERVER_SERVICE_TOKEN='AAEAAWVsYXN0aWMvZmxlZXQtc2VydmVyL3Rva2VuLTE2NDg1NTAwNzI1Nzg6RE5ISGJkVEFTQXVLMjRsY2dtM2t0dw' \
  --env FLEET_CA='/usr/share/elastic-agent/certs/ca.crt' \
  --env CERTIFICATE_AUTHORITIES='/usr/share/elastic-agent/certs/ca.crt' \
  --env FLEET_SERVER_ES_CA='/usr/share/elastic-agent/certs/http_ca.crt' \
  --env FLEET_SERVER_CERT='/usr/share/elastic-agent/certs/fleet-server.crt' \
  --env FLEET_SERVER_CERT_KEY='/usr/share/elastic-agent/certs/fleet-server.key' \
  --env FLEET_SERVER_ES_CA_TRUSTED_FINGERPRINT='92c1ddc4cd8e1eda8296f67fbd11680102aecdf2d38eaebf8ae6fe92283eeb2e' \
  --user=root \
  --volume='/var/run/docker.sock:/var/run/docker.sock:ro' \
  --volume='/home/sarah/Projects/repo/base-system/02-elasticsearch/data/elastic-agent.yml:/usr/share/elastic-agent/elastic-agent.yml:ro' \
  --volume='/home/sarah/Projects/repo/base-system/02-elasticsearch/data/ca/ca.crt:/usr/share/elastic-agent/certs/ca.crt:ro' \
  --volume='/home/sarah/Projects/repo/base-system/02-elasticsearch/data/fleet-server/fleet-server.crt:/usr/share/elastic-agent/certs/fleet-server.crt:ro' \
  --volume='/home/sarah/Projects/repo/base-system/02-elasticsearch/data/fleet-server/fleet-server.key:/usr/share/elastic-agent/certs/fleet-server.key:ro' \
  --volume='/home/sarah/Projects/repo/base-system/02-elasticsearch/data/http_ca.crt:/usr/share/elastic-agent/certs/http_ca.crt:ro' \
  docker.elastic.co/beats/elastic-agent:8.1.1

sudo ./elastic-agent install  \
  --fleet-server-es=https://localhost:9200 \
  --fleet-server-service-token=AAEAAWVsYXN0aWMvZmxlZXQtc2VydmVyL3Rva2VuLTE2NDg1NTAwNzI1Nzg6RE5ISGJkVEFTQXVLMjRsY2dtM2t0dw \
  --fleet-server-policy=fleet-server-policy \
  --fleet-server-es-ca-trusted-fingerprint=92c1ddc4cd8e1eda8296f67fbd11680102aecdf2d38eaebf8ae6fe92283eeb2e



kibana_system
Rnpl1Ahg6PMsUReEfMij