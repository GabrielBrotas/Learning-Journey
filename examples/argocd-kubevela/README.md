1. Install Minikube

```sh
# Install Minikube
minikube start --kubernetes-version=v1.28.3
```

2. Install ArgoCD

```sh
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm repo update
helm dep update charts/argo-cd/

kubectl create namespace argocd
helm install argo-cd charts/argo-cd/ -n argocd --values charts/argo-cd/values.yaml

kubectl wait pods --for=condition=Ready --timeout -1s --all -n argocd
```

3. Install KubeVela

```sh
helm repo add kubevela https://kubevela.github.io/charts
helm repo update
helm dep update charts/kubevela/

kubectl create namespace vela-system
helm install kubevela charts/kubevela/ -n vela-system
# vela install -n vela-system -v 1.9.7
```

4. port forward

```sh
# argocd ui
kubectl port-forward -n argocd service/argo-cd-argocd-server 8080:443
```

5. update argocd password

```sh
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

6. create argocd app

```sh
kubectl apply -f argo-app-of-apps.yaml -n argocd
```

## Debug Plugin

```sh
# debug:
kubectl logs -n argocd argo-cd-argocd-repo-server-7cdccb4499-mx59l -c vela
```
