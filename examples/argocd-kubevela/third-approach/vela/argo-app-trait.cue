"argo-app-trait": {
	alias: ""
	annotations: {}
	attributes: {
		appliesToWorkloads: []
		conflictsWith: []
		podDisruptive:   false
		workloadRefPath: ""
	}
	description: "Create argo app."
	labels: {}
	type: "trait"
}

template: {
	parameter: {
		name:        string
	}
	outputs: argoapp: {
		apiVersion: "argoproj.io/v1alpha1"
		kind:       "Application"
		metadata: {
			name:      parameter.name
			namespace: "argocd"
		}
		spec: {
			project: "default"
			source: {
				path:           "examples/argocd-kubevela/third-approach/app-of-apps/apps"
				repoURL:        "https://github.com/GabrielBrotas/Learning-Journey/"
				targetRevision: "argocd-kubevela"
			}
			plugin: {
				name: "vela-v1.0"
				env: [
					{
						name: "FILE_NAME"
						value: parameter.name + ".oam.yml"
					}
				]
			}
			destination: {
				namespace: "default"
				server: "https://kubernetes.default.svc"
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
}

