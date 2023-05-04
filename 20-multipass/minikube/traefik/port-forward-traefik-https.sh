multipass exec minikube -- minikube kubectl -- port-forward \
  --address 0.0.0.0 -n traefik \
  $(multipass exec minikube -- minikube kubectl -- get pods --selector "app.kubernetes.io/name=traefik" -n traefik --output=name) \
  8443:8443
