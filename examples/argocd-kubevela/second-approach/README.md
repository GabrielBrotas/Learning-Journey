## KubeVela with Argo CD Step-by-Step

### Prerequisites

Tools:

- minikube==1.31.2
- helm==3.13.3
- kubectl==1.26.8

For the platform operator, the only “trick” is to enable KubeVela as a custom plugin to Argo CD so that it will “understand” OAM (Open Application Model) resources.

### 1. Run Minikube

```sh
minikube start --kubernetes-version=v1.28.3
```

### 2. Install ArgoCD

Now we can deploy ArgoCD with the plugin:

```sh
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm repo update
helm dep update charts/argo-cd/

helm install argo-cd charts/argo-cd/ -n argocd --create-namespace

# wait for argocd ready
kubectl wait pods --for=condition=Ready --timeout -1s --all -n argocd

# argocd ui
kubectl port-forward -n argocd service/argo-cd-argocd-server 8080:443
```

Update ArgoCD password:

```sh
export PASS=$(kubectl --namespace argocd get secret argocd-initial-admin-secret \
    --output jsonpath="{.data.password}" \
    | base64 --decode)

argocd login localhost:8080 --insecure --username admin --password $PASS

argocd account update-password --current-password $PASS --new-password admin123

# login: admin
# password: admin123
```

### 3. Install KubeVela

Install KubeVela so that the `argo-repo-server` can render the OAM files into Kubernetes resources.

```sh
helm repo add kubevela https://kubevela.github.io/charts
helm repo update
helm dep update charts/kubevela/

helm install kubevela charts/kubevela/ -n vela-system --create-namespace

# wait for vela ready
kubectl wait pods --for=condition=Ready --timeout -1s --all -n vela-system
```

### 6. Use Argo CD with KubeVela

```sh
kubectl apply -f ../apps/argocd-app.yml
```

## Refs:

- https://kubevela.io/blog/2023/01/06/kubevela-argocd-integration/
