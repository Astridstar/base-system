#!/bin/bash

curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.5.1/docker-compose.yaml'

# The webserver is available at http://localhost:8080
# Web URL - http://localhost:5555
sudo docker compose --profile flower up

