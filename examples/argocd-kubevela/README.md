1. setup environment
```sh
# Install Minikube
minikube start --kubernetes-version=v1.28.3

# Install Argo CD
kubectl create namespace argocd
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm dep update charts/argo-cd/

helm install argo-cd charts/argo-cd/ -n argocd --values charts/argo-cd/values.yaml

kubectl apply -f charts/argo-cd/templates/plugin.yaml -n argocd

kubectl wait --for=condition=available --timeout=600s deployment/argo-cd-argocd-server -n argocd

# Install KubeVela
vela install -n vela-system -v 1.9.7

# velaux
# vela addon enable velaux
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

```sh
# debug:
kubectl logs -n argocd argo-cd-argocd-repo-server-7cdccb4499-mx59l -c vela
```