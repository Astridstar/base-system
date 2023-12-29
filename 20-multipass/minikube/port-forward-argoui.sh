multipass exec minikube -- minikube kubectl -- port-forward --address 0.0.0.0 -n argocd svc/argocd-server 8080:443
