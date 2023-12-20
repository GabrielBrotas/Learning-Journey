import (
	"strconv"
	"strings"
)

"com.wexinc.webservice": {
	alias: ""
	annotations: {}
	attributes: {
		workload: {
			definition: {
				apiVersion: "apps/v1"
				kind:       "Deployment"
			}
			type: "deployments.apps"
		}
	}
	description: ""
	labels: {}
	type: "component"
}


template: {
	output: {}

	outputs: {
		argocdapp: {
			apiVersion: "argoproj.io/v1alpha1"
			kind:       "Application"
			metadata: {
				name:      parameter.name
				namespace: "argocd"
			}
			spec: {
				project: parameter.project
				source: {
					path:           "examples/argocd-kubevela/third-approach/app-of-apps/apps"
					repoURL:        "https://github.com/GabrielBrotas/Learning-Journey/"
					targetRevision: "argocd-kubevela"
					directory:      {
						include: strings.Join(parameter.name, ".yml")
					}
				}
				// plugin: {
				// 	name: "vela-v1.0"
				// 	env: [
				// 		{
				// 			name: "FILE_NAME"
				// 			value: parameter.name + ".oam.yml"
				// 		}
				// 	]
				// }
				destination: {
					namespace: parameter.namespace
					server: "https://kubernetes.default.svc"
				}
				syncPolicy: {
					automated: {
						prune:    false
						selfHeal: true
					}
					syncOptions: ["CreateNamespace=true"]
				}
			}
		}

		deployment: {
			apiVersion: "apps/v1"
			kind:       "Deployment"
			spec: {
				selector: matchLabels: {
					"argocd.argoproj.io/instance": context.name
				}
				template: {
					spec: {
						containers: [{
							name:  context.name
							image: parameter.image
							if parameter["port"] != _|_ && parameter["ports"] == _|_ {
								ports: [{
									containerPort: parameter.port
								}]
							}
							if parameter["ports"] != _|_ {
								ports: [ for v in parameter.ports {
									{
										containerPort: v.port
										protocol:      v.protocol
										if v.name != _|_ {
											name: v.name
										}
										if v.name == _|_ {
											_name: "port-" + strconv.FormatInt(v.port, 10)
											name:  *_name | string
											if v.protocol != "TCP" {
												name: _name + "-" + strings.ToLower(v.protocol)
											}
										}
									}}]
							}

							if parameter["imagePullPolicy"] != _|_ {
								imagePullPolicy: parameter.imagePullPolicy
							}

							if parameter["cmd"] != _|_ {
								command: parameter.cmd
							}

							if parameter["args"] != _|_ {
								args: parameter.args
							}

							if parameter["env"] != _|_ {
								env: parameter.env
							}

							if context["config"] != _|_ {
								env: context.config
							}

							if parameter["cpu"] != _|_ {
								resources: {
									limits: cpu:   parameter.cpu
									requests: cpu: parameter.cpu
								}
							}

							if parameter["memory"] != _|_ {
								resources: {
									limits: memory:   parameter.memory
									requests: memory: parameter.memory
								}
							}

							if parameter["volumes"] != _|_ && parameter["volumeMounts"] == _|_ {
								volumeMounts: [ for v in parameter.volumes {
									{
										mountPath: v.mountPath
										name:      v.name
									}}]
							}


							if parameter["livenessProbe"] != _|_ {
								livenessProbe: parameter.livenessProbe
							}

							if parameter["readinessProbe"] != _|_ {
								readinessProbe: parameter.readinessProbe
							}

						}]

						if parameter["hostAliases"] != _|_ {
							// +patchKey=ip
							hostAliases: parameter.hostAliases
						}

						if parameter["imagePullSecrets"] != _|_ {
							imagePullSecrets: [ for v in parameter.imagePullSecrets {
								name: v
							},
							]
						}

						if parameter["volumes"] != _|_ && parameter["volumeMounts"] == _|_ {
							volumes: [ for v in parameter.volumes {
								{
									name: v.name
									if v.type == "pvc" {
										persistentVolumeClaim: claimName: v.claimName
									}
									if v.type == "configMap" {
										configMap: {
											defaultMode: v.defaultMode
											name:        v.cmName
											if v.items != _|_ {
												items: v.items
											}
										}
									}
									if v.type == "secret" {
										secret: {
											defaultMode: v.defaultMode
											secretName:  v.secretName
											if v.items != _|_ {
												items: v.items
											}
										}
									}
									if v.type == "emptyDir" {
										emptyDir: medium: v.medium
									}
								}
							}]
						}

					}
				}
			}
		}
		
		if len(exposePorts) != 0 {
			webserviceExpose: {
				apiVersion: "v1"
				kind:       "Service"
				metadata: name: context.name
				spec: {
					selector: "app.oam.dev/component": context.name
					ports: exposePorts
					type:  parameter.exposeType
				}
			}
		}
	}

	exposePorts: [
		if parameter.ports != _|_ for v in parameter.ports if v.expose == true {
			port:       v.port
			targetPort: v.port
			if v.name != _|_ {
				name: v.name
			}
			if v.name == _|_ {
				_name: "port-" + strconv.FormatInt(v.port, 10)
				name:  *_name | string
				if v.protocol != "TCP" {
					name: _name + "-" + strings.ToLower(v.protocol)
				}
			}
			if v.nodePort != _|_ && parameter.exposeType == "NodePort" {
				nodePort: v.nodePort
			}
			if v.protocol != _|_ {
				protocol: v.protocol
			}
		},
	]

parameter: {
		namespace: string

		// +usage=Specify the labels in the workload
		labels?: [string]: string

		// +usage=Specify the annotations in the workload
		annotations?: [string]: string

		// +usage=Which image would you like to use for your service
		// +short=i
		image: string

		// +usage=Specify image pull policy for your service
		imagePullPolicy?: "Always" | "Never" | "IfNotPresent"

		// +usage=Specify image pull secrets for your service
		imagePullSecrets?: [...string]

		// +ignore
		// +usage=Deprecated field, please use ports instead
		// +short=p
		port?: int

		// +usage=Which ports do you want customer traffic sent to, defaults to 80
		ports?: [...{
			// +usage=Number of port to expose on the pod's IP address
			port: int
			// +usage=Name of the port
			name?: string
			// +usage=Protocol for port. Must be UDP, TCP, or SCTP
			protocol: *"TCP" | "UDP" | "SCTP"
			// +usage=Specify if the port should be exposed
			expose: *false | bool
			// +usage=exposed node port. Only Valid when exposeType is NodePort
			nodePort?: int
		}]

		// +ignore
		// +usage=Specify what kind of Service you want. options: "ClusterIP", "NodePort", "LoadBalancer"
		exposeType: *"ClusterIP" | "NodePort" | "LoadBalancer"

		// +ignore
		// +usage=If addRevisionLabel is true, the revision label will be added to the underlying pods
		addRevisionLabel: *false | bool

		// +usage=Commands to run in the container
		cmd?: [...string]

		// +usage=Arguments to the entrypoint
		args?: [...string]

		// +usage=Define arguments by using environment variables
		env?: [...{
			// +usage=Environment variable name
			name: string
			// +usage=The value of the environment variable
			value?: string
			// +usage=Specifies a source the value of this var should come from
			valueFrom?: {
				// +usage=Selects a key of a secret in the pod's namespace
				secretKeyRef?: {
					// +usage=The name of the secret in the pod's namespace to select from
					name: string
					// +usage=The key of the secret to select from. Must be a valid secret key
					key: string
				}
				// +usage=Selects a key of a config map in the pod's namespace
				configMapKeyRef?: {
					// +usage=The name of the config map in the pod's namespace to select from
					name: string
					// +usage=The key of the config map to select from. Must be a valid secret key
					key: string
				}
			}
		}]

		// +usage=Number of CPU units for the service, like `0.5` (0.5 CPU core), `1` (1 CPU core)
		cpu?: string

		// +usage=Specifies the attributes of the memory resource required for the container.
		memory?: string

		volumeMounts?: {
			// +usage=Mount PVC type volume
			pvc?: [...{
				name:      string
				mountPath: string
				subPath?:  string
				// +usage=The name of the PVC
				claimName: string
			}]
			// +usage=Mount ConfigMap type volume
			configMap?: [...{
				name:        string
				mountPath:   string
				subPath?:    string
				defaultMode: *420 | int
				cmName:      string
				items?: [...{
					key:  string
					path: string
					mode: *511 | int
				}]
			}]
			// +usage=Mount Secret type volume
			secret?: [...{
				name:        string
				mountPath:   string
				subPath?:    string
				defaultMode: *420 | int
				secretName:  string
				items?: [...{
					key:  string
					path: string
					mode: *511 | int
				}]
			}]
			// +usage=Mount EmptyDir type volume
			emptyDir?: [...{
				name:      string
				mountPath: string
				subPath?:  string
				medium:    *"" | "Memory"
			}]
			// +usage=Mount HostPath type volume
			hostPath?: [...{
				name:      string
				mountPath: string
				subPath?:  string
				path:      string
			}]
		}

		// +usage=Deprecated field, use volumeMounts instead.
		volumes?: [...{
			name:      string
			mountPath: string
			// +usage=Specify volume type, options: "pvc","configMap","secret","emptyDir", default to emptyDir
			type: *"emptyDir" | "pvc" | "configMap" | "secret"
			if type == "pvc" {
				claimName: string
			}
			if type == "configMap" {
				defaultMode: *420 | int
				cmName:      string
				items?: [...{
					key:  string
					path: string
					mode: *511 | int
				}]
			}
			if type == "secret" {
				defaultMode: *420 | int
				secretName:  string
				items?: [...{
					key:  string
					path: string
					mode: *511 | int
				}]
			}
			if type == "emptyDir" {
				medium: *"" | "Memory"
			}
		}]

		// +usage=Specify the hostAliases to add
		hostAliases?: [...{
			ip: string
			hostnames: [...string]
		}]
	}

}
