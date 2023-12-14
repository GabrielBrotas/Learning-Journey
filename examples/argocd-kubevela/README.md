1. setup environment
```sh
# Install Minikube
minikube start --kubernetes-version=v1.28.3

# Install Argo CD
kubectl create namespace argocd
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm dep update charts/argo-cd/

kubectl apply -f charts/argo-cd/templates/plugin.yaml -n argocd

helm install argo-cd charts/argo-cd/ -n argocd --values charts/argo-cd/values.yaml

kubectl wait --for=condition=available --timeout=600s deployment/argo-cd-argocd-server -n argo-system

# Install KubeVela
vela install -n vela-system -v 1.6.4

# velaux
vela addon enable velaux
```

```sh
# port-forward
kubectl port-forward -n argo-system service/argo-cd-argocd-server 8080:443
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

create vela app:

```sh
argocd app create first-vela-app \
  --dest-namespace="default" \
  --dest-server=https://kubernetes.default.svc \
  --config-management-plugin=vela \
  --plugin-env="APPFILE_PATH=appfile.yaml" \
  --repo="https://github.com/GabrielBrotas/Advanced-Journey" \
  --path="./examples/argocd-kubevela" \
  --revision="main"

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