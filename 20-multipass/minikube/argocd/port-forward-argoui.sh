multipass exec minikube -- minikube kubectl -- port-forward \
  --address 0.0.0.0 -n argocd \
  $(multipass exec minikube -- minikube kubectl -- get pods --selector "app.kubernetes.io/name=argocd-server" -n argocd --output=name) \
  8080:8080
