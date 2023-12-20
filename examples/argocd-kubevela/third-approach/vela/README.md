```sh
# Minikube
minikube start --kubernetes-version=v1.28.3

# Argo
helm install argo-cd charts/argo-cd/ -n argocd --values charts/argo-cd/values.yaml --create-namespace
kubectl wait pods --for=condition=Ready --timeout -1s --all -n argocd
kubectl port-forward -n argocd service/argo-cd-argocd-server 8080:443

# Argo Password
export PASS=$(kubectl --namespace argocd get secret argocd-initial-admin-secret --output jsonpath="{.data.password}" | base64 --decode)
argocd login localhost:8080 --insecure --username admin --password $PASS
argocd account update-password --current-password $PASS --new-password admin123

# Vela
helm install kubevela charts/kubevela/ -n vela-system --create-namespace

# Vela template
vela def init argo-app -t component --template-yaml ./argocd-app.yaml -o argo-app.cue
```

