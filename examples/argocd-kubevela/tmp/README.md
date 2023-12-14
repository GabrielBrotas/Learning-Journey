# Introduction

[Argo CD](https://github.com/argoproj/argo-cd/) is a GitOps continuous delivery tool for Kubernetes. It is a part of the CNCF Argo Project, a set of Kubernetes-native tools for running and managing jobs and applications on Kubernetes.

[KubeVela](https://github.com/kubevela/kubevela) is an open source application engine based on Kubernetes and OAM (Open Application Model). KubeVela is designed primarily for platform and operations teams to easily create simple yet highly extensible developer-facing abstractions on Kubernetes. This hides much of the complexity of configuring application manifests on Kubernetes such as scaling policies, deployment strategies and ingress from developers (aka end users) but allows platform teams to independently customize and control these configurations based on organizational policies.

In this blog post, we will share our experiences using Argo CD and KubeVela to build developer-centric continuous app delivery pipelines based on Alibaba Cloud’s use case.

## GitOps with Developer-centric Experience

Ideally, developers want to focus on writing applications and pushing their code to git repos without worrying about CI/CD pipelines and other operational issues in configuring and running applications. A very popular pattern on Kubernetes is to automatically deploy applications from git to production. This is where Argo CD comes in. It continuously watches git repos for new commits, and automatically deploys them to production. Argo CD applies pre-defined Kubernetes deployment manifest files in the repo to provision or upgrade the application running on Kubernetes. This pattern, known as GitOps, is the key to enable continuous automatic app delivery in the modern cloud-native stack at Alibaba.

While conceptually simple, there are several important issues that emerge when applying GitOps to broader end user scenarios. The first issue, is that a real-world production application is complex, and requires developers to understand how to configure many different types of Kubernetes resources. The second issue, which is related to the first, is that it becomes super challenging for each developer to learn how to properly configure and maintain all these objects while complying with organizational security, compliance and operational policies. Even a simple mis-configuration may lead to failed deployments or even service unavailablity. The third issue is when there is a change to Kubernetes specs or organizational policies, ALL application manifests must be updated to reflect these changes. This is a HUGE undertaking for an organization that may have thousands of applications and millions of lines of YAML for Kubernetes manifest files. These issues create a strong need for an application abstraction that isolates developers from platform and operational concerns that do not directly affect their application and provides an anchor to avoid configuration drift. The core Kubernetes abstraction, by intentional design, do not provide a standard mechanism to abstract applications.

With this goal in mind, KubeVela is created and designed as a minimal, extensible application engine for platform builders to create “PaaS-like” experiences on Kubernetes. Specifically, KubeVela provides simple and effective abstraction that separates application configuration concerns from platform and operation concerns. Here is an example of the artifact, which is named `appfile`:

```yaml
name: testapp

services:
  express-server:
    type: webservice
    image: "oamdev/testapp:v1"
    build:
      docker:
        file: Dockerfile
        context: .
    cmd: ["node", "server.js"]
    port: 8080
    cpu: "0.1"

    route:
      domain: "example.com"
      rules:
        - path: /testapp
          rewriteTarget: /

    autoscale:
      min: 1
      max: 10
      cpuPercent: 5
```

By using `appfile` and deploying it with Argo CD, developers just need to write a simple application config and push their code to git. Thier application will then be automatically deployed and start serving live traffic on the target Kubernetes cluster. Behind the scenes, platform and operations teams have the power to pre-define and/or modify the behavior of these abstractions with CUElang templates and ensure they meet organizational security, compliance and other operational requirements.

In the section below, we will explain how above GitOps workflow works in greater detail.

## KubeVela with Argo CD Step-by-Step

### Prerequisites

For the platform operator, the only “trick” is to enable KubeVela as a custom plugin to Argo CD so that it will “understand” the appfile format.

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
# argocd password: <get from secret>
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
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
