# Introduction

[Argo CD](https://github.com/argoproj/argo-cd/) is a GitOps continuous delivery tool for Kubernetes. It is a part of the CNCF Argo Project, a set of Kubernetes-native tools for running and managing jobs and applications on Kubernetes.

[KubeVela](https://github.com/kubevela/kubevela) is an open source application engine based on Kubernetes and OAM (Open Application Model). KubeVela is designed primarily for platform and operations teams to easily create simple yet highly extensible developer-facing abstractions on Kubernetes. This hides much of the complexity of configuring application manifests on Kubernetes such as scaling policies, deployment strategies and ingress from developers (aka end users) but allows platform teams to independently customize and control these configurations based on organizational policies.

In this guide, you'll learn how to integrate Argo CD and KubeVela.

## GitOps with Developer-centric Experience

Ideally, developers want to focus on writing applications and pushing their code to git repos without worrying about CI/CD pipelines and other operational issues in configuring and running applications. A very popular pattern on Kubernetes is to automatically deploy applications from git to production. This is where Argo CD comes in. It continuously watches git repos for new commits, and automatically deploys them to production. Argo CD applies pre-defined Kubernetes deployment manifest files in the repo to provision or upgrade the application running on Kubernetes. This pattern, known as GitOps, is the key to enable continuous automatic app delivery in the modern cloud-native stack at Alibaba.

While conceptually simple, there are several important issues that emerge when applying GitOps to broader end user scenarios. The first issue, is that a real-world production application is complex, and requires developers to understand how to configure many different types of Kubernetes resources. The second issue, which is related to the first, is that it becomes super challenging for each developer to learn how to properly configure and maintain all these objects while complying with organizational security, compliance and operational policies. Even a simple mis-configuration may lead to failed deployments or even service unavailablity. The third issue is when there is a change to Kubernetes specs or organizational policies, ALL application manifests must be updated to reflect these changes. This is a HUGE undertaking for an organization that may have thousands of applications and millions of lines of YAML for Kubernetes manifest files. These issues create a strong need for an application abstraction that isolates developers from platform and operational concerns that do not directly affect their application and provides an anchor to avoid configuration drift. The core Kubernetes abstraction, by intentional design, do not provide a standard mechanism to abstract applications.

With this goal in mind, KubeVela is created and designed as a minimal, extensible application engine for platform builders to create “PaaS-like” experiences on Kubernetes. Specifically, KubeVela provides simple and effective abstraction that separates application configuration concerns from platform and operation concerns. Here is an example of the artifact, which is named `first-vela-app`:

```yaml
apiVersion: core.oam.dev/v1beta1
kind: Application
metadata:
  name: first-vela-app
spec:
  components:
    - name: express-server
      type: webservice
      properties:
        image: oamdev/hello-world
        ports:
          - port: 8000
            expose: true
      traits:
        - type: scaler
          properties:
            replicas: 2
```

By using `first-vela-app` and deploying it with Argo CD, developers just need to write a simple application config and push their code to git. Thier application will then be automatically deployed and start serving live traffic on the target Kubernetes cluster. Behind the scenes, platform and operations teams have the power to pre-define and/or modify the behavior of these abstractions with `CUElang` templates and ensure they meet organizational security, compliance and other operational requirements.

In the section below, we will explain how above GitOps workflow works in greater detail.

## KubeVela with Argo CD Step-by-Step

### Prerequisites

Tools:

- minikube==1.31.2
- helm==3.13.3
- kubectl==1.26.8

For the platform operator, the only “trick” is to enable KubeVela as a custom plugin to Argo CD so that it will “understand” the OAM CRD.

### Environment Setup

1. Install Minikube

```sh
minikube start --kubernetes-version=v1.28.3
```

2. Install ArgoCD

```sh
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm repo update
helm dep update charts/argo-cd/

helm install argo-cd charts/argo-cd/ -n argocd --values charts/argo-cd/values.yaml --create-namespace

# wait for argocd ready
kubectl wait pods --for=condition=Ready --timeout -1s --all -n argocd

# argocd ui
kubectl port-forward -n argocd service/argo-cd-argocd-server 8080:443
```

_Note_: This ArgoCD chart is updated with the plugin to support `kubevela`, we will explain the details in the next section.

3. Update ArgoCD password

```sh
export PASS=$(kubectl --namespace argocd get secret argocd-initial-admin-secret \
    --output jsonpath="{.data.password}" \
    | base64 --decode)

argocd login localhost:8080 --insecure --username admin --password $PASS

argocd account update-password --current-password $PASS --new-password admin123

# argocd login: admin
# argocd password: admin123
```

4. Install KubeVela

```sh
helm repo add kubevela https://kubevela.github.io/charts
helm repo update
helm dep update charts/kubevela/

helm install kubevela charts/kubevela/ -n vela-system --create-namespace

# wait for vela ready
kubectl wait pods --for=condition=Ready --timeout -1s --all -n vela-system
```

5. Deploy `first-vela-app.oam.yml` using ArgoCD application file

```sh
kubectl apply -f apps/argocd-app.yml
```

### Register plugin

Argo CD allows integrating additional config management plugins like for Kubevela by editing the argocd-cm ConfigMap.

Save the following as `argo-cm.yaml`:

```yaml
data:
  configManagementPlugins: |
    - name: vela
      init:
        command: ["sh", "-xc"]
        args: ["vela traits"]
      generate:
        command: ["sh", "-xc"]
        args: ["vela export"]
```

Then run the following command to update the `argocd-cm` ConfigMap:

```sh
kubectl -n argocd patch cm/argocd-cm -p "$(cat ./examples/argocd-kubevela/argo-cm.yaml)"
```

### Configure argo-repo-server

Argo CD has a component called `argo-repo-server` which pulls the deployment manifest files from Git and renders the final output. This is where we will use the vela cli to parse the `appfile` and render it into Kubernetes resources.

First, create the ConfigMap with the required kubeconfig credential to talk to the target Kubernetes cluster where KubeVela should already be installed:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: vela-kubeconfig
  namespace: argocd
data:
  config: | # fill your kubeconfig here
```

Once the above ConfigMap is created, update the `argo-repo-server` to hold the vela cli and credentials.

Save the following patch file as `deploy.yaml`:

```yaml
spec:
  template:
    spec:
      # 1. Define an emptyDir volume which will hold the custom binaries
      volumes:
        - name: custom-tools
          emptyDir: {}
        - name: vela-kubeconfig
          configMap:
            name: vela-kubeconfig
      # 2. Use an init container to download/copy custom binaries
      initContainers:
        - name: download-tools
          image: oamdev/argo-tool:v1
          command: [sh, -c]
          args:
            - cp /app/vela /custom-tools/vela
          volumeMounts:
            - mountPath: /custom-tools
              name: custom-tools
      # 3. Volume mount the custom binary to the bin directory
      containers:
        - name: argocd-repo-server
          env:
            - name: KUBECONFIG
              value: /home/argocd/.kube/config
          volumeMounts:
            - mountPath: /usr/local/bin/vela
              name: custom-tools
              subPath: vela
            - mountPath: /home/argocd/.kube/
              name: vela-kubeconfig
```

Then run the following command to update the `argocd-repo-server` Deployment:

```sh
kubectl -n argocd patch deploy/argocd-repo-server -p "$(cat deploy.yaml)"
```

By now the vela plugin should have been registered and the argo-repo-server should have access to the vela cli to render the appfile into Kubernetes resources.

Use Argo CD with KubeVela
Now, acting as the application developer, you can deploy the app specified using KubeVela via GitOps. Just remember to specify the plugin name when creating apps via the argocd cli:

argocd app create <appName> --config-management-plugin vela
Let’s walk through a demo with the Argo CD UI as well. Here is an example repo that contains the appfile to deploy:

https://github.com/hongchaodeng/argocd-example-apps/tree/master/appfile

Configure Argo CD to watch this repo for Git pushes, including the initial state:

Repo screenshot
Any pushes to the repo will now be automatically detected and deployed:

Argo CD screenshot
That’s it! Now you can create/modify appfiles, push to git, and Argo CD will automatically deploy them to your Kubernetes cluster, all via the magic of GitOps!

## Refs:

- https://www.cncf.io/blog/2020/12/22/argocd-kubevela-gitops-with-developer-centric-experience/
- https://kubevela.io/blog/2023/01/06/kubevela-argocd-integration/

2. Install ArgoCD

```sh
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm repo update
helm dep update charts/argo-cd/

kubectl create namespace argocd
helm install argo-cd charts/argo-cd/ -n argocd --values charts/argo-cd/values.yaml

```

3. Install KubeVela

```sh

```

4. port forward

```sh
# argocd ui
kubectl port-forward -n argocd service/argo-cd-argocd-server 8080:443
```

6. create argocd app-of-apps

```sh
kubectl apply -f argo-app-of-apps.yaml -n argocd
```

7. access the apps

```sh
k create ns vela-app
```

## Debug Plugin

You can debug the plugin by running the following command to print the logs of the `argo-repo-server` pod in the `vela` container:

```sh
kubectl logs -n argocd argo-cd-argocd-repo-server-7cdccb4499-mx59l -c vela
```
