multipass exec $1 -- minikube kubectl -- port-forward --address 0.0.0.0 -n argocd service/argocd-server 8080:443
