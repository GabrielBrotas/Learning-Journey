1. setup environment
```sh
# Install Minikube
minikube start --kubernetes-version=v1.28.3

# Install Argo CD
kubectl create namespace argo-system
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.9.2/manifests/install.yaml



kubectl wait --for=condition=available --timeout=600s deployment/argocd-server -n argocd
```

```sh
# port-forward
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

```sh
# update argocd password
export PASS=$(kubectl \
    --namespace argocd \
    get secret argocd-initial-admin-secret \
    --output jsonpath="{.data.password}" \
    | base64 --decode)

argocd login localhost:8080 \
    --insecure \
    --username admin \
    --password $PASS

argocd account update-password \
    --current-password $PASS \
    --new-password admin123

# argocd login: admin
# argocd password: admin123
```


2. setup kubevela
```sh
# install vela
vela install

# velaux
vela addon enable velaux

# port-forward
vela port-forward addon-velaux -n vela-system 8000:8000
```

3. setup kubevela app

```sh
# This command will create a namespace in the local cluster
vela env init prod --namespace prod

vela up -f examples/argocd-kubevela/app.yaml

vela status first-vela-app

vela port-forward first-vela-app 8001:8000

# After we finished checking the application, we can approve the workflow to continue:
vela workflow resume first-vela-app

vela status first-vela-app
```

4. clean up
```sh
vela delete first-vela-app
```