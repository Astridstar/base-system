#!/bin/bash

kubectl create deployment balanced --image=kicbase/echo-server:1.0
kubectl expose deployment balanced --type=LoadBalancer --port=8080

#In another window, start the tunnel to create a routable IP for the ‘balanced’ deployment:

#$ minikube tunnel
#To find the routable IP, run this command and examine the EXTERNAL-IP column:

#$ kubectl get services balanced
#Your deployment is now available at <EXTERNAL-IP>:8080