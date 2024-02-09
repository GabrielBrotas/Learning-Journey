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
helm upgrade argocd -n argocd ./argocd \
  -f ./argocd/values.yaml \
  -f ./argocd/resources/applications.yaml \
  -f ./argocd/resources/projects.yaml \
  --create-namespace

kubectl get pods -n argocd

# admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

# login: admin
# pass: r4GdV7rz0DsyvQ0G

kubectl -n argocd port-forward svc/argocd-server 8080:443
```


## Refs:

- https://blog.kintone.io/entry/production-grade-delivery-workflow-using-argocd#Multi-tenancy
- https://github.com/cybozu/neco-containers/tree/main/admission
- https://github.com/cybozu/neco-containers/blob/main/admission/docs/configuration.md#argocdapplicationvalidator