
### Environment Setup

```sh
# Install Minikube
minikube start --kubernetes-version=v1.28.3

# Install Argo CD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl wait --for=condition=available --timeout=600s deployment/argocd-server -n argocd

kubectl port-forward svc/argocd-server -n argocd 8080:443

# argocd login: admin
# argocd password: <get from secret>, AOAbRJSWLavvePWz
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# install vela
vela install

# velaux
vela addon enable velaux

# 
vela port-forward addon-velaux -n vela-system
```

### Register plugin
```sh
kubectl apply -f examples/argocd-kubevela/vela-cmp.yaml
```

```sh
kubectl -n argocd patch deploy/argocd-repo-server -p "$(cat examples/argocd-kubevela/deploy.yaml)"
kubectl -n argocd patch deploy/argocd-repo-server -p "$(cat examples/argocd-kubevela/argo-cm.yaml)"
```