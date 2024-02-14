# ArgoCD Multi Tenancy and Kyverno 

All the commands are executed from this directory.

## 1 - Initial Setup

1. start a minikube cluster:

```bash
minikube start --kubernetes-version=v1.28.3
```

2. install argocd:

```sh
helm dep build ./argocd

kubectl create namespace argocd

helm install argocd -n argocd ./argocd \
  -f ./argocd/values.yaml

# wait for argocd ready
kubectl wait pods --for=condition=Ready --timeout -1s --all -n argocd

# argocd ui
kubectl -n argocd port-forward svc/argocd-server 8080:443
```

3. Update ArgoCD password:

```sh
export PASS=$(kubectl --namespace argocd get secret argocd-initial-admin-secret \
    --output jsonpath="{.data.password}" \
    | base64 --decode)

argocd login localhost:8080 --insecure --username admin --password $PASS

argocd account update-password --current-password $PASS --new-password admin123

# login: admin
# password: admin123
```

4. install project and apps:
```sh
kubectl create namespace tenant-a-dev
kubectl create namespace tenant-b-dev

kubectl apply -f ./resources/projects

kubectl apply -f ./resources/app-of-apps
```

5. install kyverno:

```sh
kubectl create -f https://github.com/kyverno/kyverno/releases/download/v1.11.1/install.yaml
```

6. install kyverno policies:

```sh
kubectl apply -f ./resources/policies
```

## Refs:

- https://blog.kintone.io/entry/production-grade-delivery-workflow-using-argocd#Multi-tenancy
- https://github.com/cybozu/neco-containers/tree/main/admission
- https://github.com/cybozu/neco-containers/blob/main/admission/docs/configuration.md#argocdapplicationvalidator