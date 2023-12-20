"argo-app": {
	alias: ""
	annotations: {}
	attributes: workload: definition: {
		apiVersion: "<change me> apps/v1"
		kind:       "<change me> Deployment"
	}
	description: ""
	labels: {}
	type: "component"
}

template: {
	output: {
		apiVersion: "argoproj.io/v1alpha1"
		kind:       "Application"
		metadata: {
			name:      "first-vela-app"
			namespace: "argocd"
		}
		spec: {
			destination: {
				namespace: "default"
				server:    "https://kubernetes.default.svc"
			}
			project: "default"
			source: {
				path:           "examples/argocd-kubevela/first-approach/apps"
				repoURL:        "https://github.com/GabrielBrotas/Learning-Journey/"
				targetRevision: "HEAD"
			}
			syncPolicy: {
				automated: {
					prune:    true
					selfHeal: true
				}
				syncOptions: ["CreateNamespace=true"]
			}
		}
	}
	outputs: {}
	parameter: {
		name:        "first-vela-app"
		description: "The name of the application"
		required:    true
	}
}
