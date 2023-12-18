# Introduction

[Argo CD](https://github.com/argoproj/argo-cd/) is a GitOps continuous delivery tool for Kubernetes. It is a part of the CNCF Argo Project, a set of Kubernetes-native tools for running and managing jobs and applications on Kubernetes.

[KubeVela](https://github.com/kubevela/kubevela) is an open source application engine based on Kubernetes and OAM (Open Application Model). KubeVela is designed primarily for platform and operations teams to easily create simple yet highly extensible developer-facing abstractions on Kubernetes. This hides much of the complexity of configuring application manifests on Kubernetes such as scaling policies, deployment strategies and ingress from developers (aka end users) but allows platform teams to independently customize and control these configurations based on organizational policies.

In this guide, you'll learn how to integrate Argo CD and KubeVela.

## GitOps with Developer-centric Experience

### GitOps

Developers often want to focus on writing applications and pushing their code to Git repositories without being burdened by the complexities of configuring and running applications, especially in CI/CD pipelines. A popular approach on Kubernetes is to automatically deploy applications from Git to production, and this is where Argo CD comes into play. Argo CD continuously monitors Git repositories for new commits and automates the deployment process, applying pre-defined Kubernetes deployment manifest files to provision or upgrade applications running on Kubernetes. This practice, known as GitOps, is crucial for achieving continuous and automatic application delivery in the modern cloud-native stack, especially at Alibaba.

While GitOps is conceptually straightforward, there are key challenges when applying it to broader end-user scenarios.

- Complexity of Real-world Applications:

  - Production applications are complex, requiring developers to configure various types of Kubernetes resources.

- Learning Curve and Maintenance:

  - Developers face challenges in learning how to configure and maintain diverse objects, adhering to organizational security, compliance, and operational policies.
  - Misconfigurations can lead to deployment failures or service unavailability.

- Updates and Manifest Management:

  - Changes to Kubernetes specs or organizational policies necessitate updating all application manifests, a monumental task for organizations with numerous applications and extensive YAML files.

### KubeVela

Addressing these challenges, KubeVela is created as a minimal, extensible application engine designed to offer "PaaS-like" experiences on Kubernetes. KubeVela provides a simple and effective abstraction that separates application configuration concerns from platform and operational concerns.

Here is an example of the artifact, which is named `first-vela-app`:

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

## ArgoCD + Kubevela Integration

This document aims to explain the integration of Kubevela and ArgoCD. We have two approaches to integrate this flow. This doc is trying to explain the pros and cons of two different approaches.

1. [ArgoCD with Kubevela as a plugin - Kubevela dry-run option](./first-approach/README.md)
2. [Kubevela Controller + ArgoCD Gitops syncer](./second-approach/README.md)

**Conclusion:**

1. Vela Dry-run option

   - Kubevela can be installed different cluster from ArgoCD.
   - Limited Kubevela features, we just use component and traits definition.
   - Workflow and policy features don’t supported by this way.
   - Depend on Kubevela dry run feature.
   - No needed rbac, ui or any different experience from ARGO.

2. Kubevela Controller + ArgoCD Gitops syncer

   - Kubevela must be installed to ArgoCD cluster.
   - We can use all the features of Kubevela.
   - No need depends on anything.

## Refs:

- https://kubevela.io/blog/2023/01/06/kubevela-argocd-integration/
