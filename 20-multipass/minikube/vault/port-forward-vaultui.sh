multipass exec minikube -- minikube kubectl -- port-forward --address 0.0.0.0 svc/argocd-server 8200:8200
