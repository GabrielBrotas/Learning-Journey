# Istio


## Tests

**Requirements:**
- minikube
- kubectl
- istioctl

### 1. Install Istio CLI

```bash
# 1. Download Istio CLI
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.19.0 TARGET_ARCH=x86_64 sh -

# 2. Move to the Istio package directory. For example, if the package is istio-1.19.0:
cd istio-1.19.0

# 3. Add the istioctl client to your path (Linux or macOS):
export PATH=$PWD/bin:$PATH
```

### 2. Start and Setup Minikube

```sh
# 1. Start Minikube
minikube start --kubernetes-version=v1.26.8

# You may need to update your Kubectl to the same version as your Minikube cluster
# see: https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
kubectl config use-context minikube

# 2. Install istio with the demo Istio configuration profile:
istioctl install --set profile=demo -y

# 3. Add a namespace label to instruct Istio to automatically inject Envoy sidecar proxies when you deploy your application later:
kubectl label namespace default istio-injection=enabled

# 4. Install the Istio Gateway API CRDs:
# kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
#   { kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v0.8.1" | kubectl apply -f -; }


# 5. Run this command in a new terminal window to start a Minikube tunnel that sends traffic to your Istio Ingress Gateway. This will provide an external load balancer, EXTERNAL-IP, for service/istio-ingressgateway.
minikube tunnel

# 6. Set the ingress host and ports:
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

# 7.1 Ensure an IP address and ports were successfully assigned to each environment variable:
echo "$INGRESS_HOST"
echo "$INGRESS_PORT"
echo "$SECURE_INGRESS_PORT"

# 7.2 Set GATEWAY_URL:
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
echo "$GATEWAY_URL"
```

### 3. Deploy Apps

#### 1. Deploy the sample istio application
```sh
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/bookinfo/platform/kube/bookinfo.yaml

kubectl get pods --watch
kubectl get services

# wait until all pods report READY 2/2 and STATUS Running before you go to the next step. This might take a few minutes depending on your platform.

# Verify everything is working correctly up to this point. Run this command to see if the app is running inside the cluster and serving HTML pages by checking for the page title in the response:
kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"

# To make it accessible from outside of the cluster, you need to create an Istio Ingress Gateway, which maps a path to a route at the edge of your mesh.
# Associate this application with the Istio gateway:
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/bookinfo/networking/bookinfo-gateway.yaml

# Ensure that there are no issues with the configuration:
istioctl analyze

# Ensure an IP address and port were successfully assigned to the environment variable:
echo "$GATEWAY_URL"

# Confirm that the Bookinfo application is accessible from outside by viewing the Bookinfo product page using a browser.

# Run the following command to retrieve the external address of the Bookinfo application.
echo "http://$GATEWAY_URL/productpage"

# Paste the output from the previous command into your web browser and confirm that the Bookinfo product page is displayed.
```

#### 2. Install Addons

Istio integrates with several different telemetry applications. These can help you gain an understanding of the structure of your service mesh, display the topology of the mesh, and analyze the health of your mesh.

Use the following instructions to deploy the Kiali dashboard, along with Prometheus, Grafana, and Jaeger.

```sh
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/addons/prometheus.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/addons/kiali.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/addons/jaeger.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/addons/grafana.yaml

kubectl rollout status deployment/kiali -n istio-system

# Access the Kiali dashboard.
istioctl dashboard kiali

# To see trace data, you must send requests to your service. The number of requests depends on Istio’s sampling rate and can be configured using the Telemetry API. With the default sampling rate of 1%, you need to send at least 100 requests before the first trace is visible. To send a 100 requests to the productpage service, use the following command:

URL="http://$GATEWAY_URL/productpage"
NUM_REQUESTS=100

../run-requests.sh $URL $NUM_REQUESTS

# In the Kiali Dashboad, In the left navigation menu, select Graph and in the Namespace drop down, select default.
# The Kiali dashboard shows an overview of your mesh with the relationships between the services in the Bookinfo sample application. It also provides filters to visualize the traffic flow.
```

clean up sample istio app
```sh
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/bookinfo/platform/kube/bookinfo.yaml
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.19/samples/bookinfo/networking/bookinfo-gateway.yaml
```




## Stress test
kubectl apply -n istio-ingress -f https://raw.githubusercontent.com/istio/istio/release-1.16/samples/httpbin/sample-client/fortio-deploy.yaml
export FORTIO_POD=$(kubectl get pods -n istio-ingress -l app=fortio -o 'jsonpath={.items[0].metadata.name}')
kubectl exec "$FORTIO_POD" -n istio-ingress -c fortio -- /usr/bin/fortio load -c 2 -qps 0 -t 200s -loglevel Warning http://nginx:80/
```

2. fault injection
```sh
kubectl apply -n istio-ingress -f apps/3-fault-injection

export FORTIO_POD=$(kubectl get pods -n istio-ingress -l app=fortio -o 'jsonpath={.items[0].metadata.name}')
kubectl exec "$FORTIO_POD" -n istio-ingress -c fortio -- /usr/bin/fortio load -c 2 -qps 0 -t 10s -loglevel Warning http://nginx:80/
```

3. ingress
```sh
kubectl apply -n istio-ingress -f apps/5-ingress

minikube service istio-ingress -n istio-ingress --url

```