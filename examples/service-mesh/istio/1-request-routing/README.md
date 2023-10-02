# Request Routing

This example consists of 2 separate microservices (nginx apps), each with multiple versions. To illustrate the problem this causes, update the virtual service to have the following configuration:

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: nginx-vs
spec:
  hosts:
    - "*"
  gateways:
    - nginx-gateway
  http:
    - match:
        - uri:
            exact: "/"
      route:
        - destination:
            host: nginx
            port:
              number: 80
```

and comment out the destination rules resource. When you apply these changes, access the nginx app at `localhost/` in a browser and refresh several times.

You’ll notice that sometimes the nginx output contains `Hello from nginx-v1!` and other time `Hello from nginx-v2!`. This is because without an explicit default service version to route to, Istio routes requests to all available versions in a round robin fashion.

Run the following script to visualize the traffic routing in kiali:

```sh
URL="http://127.0.0.1:80/"
NUM_REQUESTS=100

../run-requests.sh $URL $NUM_REQUESTS
```

The traffic distribution in this first example is 50/50 between the two versions of the nginx app.

_Note: In the Kiali dashboard -> Graph make sure to select Display: Traffic Distribution to see the traffic distribution between the two versions of the nginx app._

## Task 1: Weighted routing

In this task, you will configure Istio to route 70% of the traffic to v1 of the nginx app and 30% to v2.

First, we create a Destination Rule to specify how the load balancing should be performed between these subsets. **DestinationRule** defines policies that apply to traffic intended for a service after routing has occurred. These rules specify configuration for load balancing, connection pool size from the sidecar, and outlier detection settings to detect and evict unhealthy hosts from the load balancing pool.

In this case we are using a simple ROUND_ROBIN load balancing algorithm, which distributes traffic evenly across available subsets.

```yaml
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: nginx-dr
spec:
  host: nginx # DestinationRule for the host "nginx" corresponding to the Kubernetes service named "nginx"
  trafficPolicy: # traffic policy for load balancing:
    loadBalancer: # load balancing policy is
      simple: ROUND_ROBIN # "ROUND_ROBIN" load balancing algorithm, which distributes traffic evenly across available subsets.
  subsets:
    - name: v1
      labels:
        version: v1
    - name: v2
      labels:
        version: v2
```

Then, in the Virtual Service, we specify the weights for each subset:

```yaml

---
route:
  - destination:
      host: nginx
      port:
        number: 80
      subset: v1
    weight: 70 # 70% of traffic to subset v1
  - destination:
      host: nginx
      subset: v2
    weight: 30 # 30% of traffic to subset v2
```

Apply the configuration and run the tests:

```sh
k apply -f .

istioctl analyze # check for any configuration errors

# run the tests
URL="http://127.0.0.1:80/"
NUM_REQUESTS=100

../run-requests.sh $URL $NUM_REQUESTS

# check the kiali dashboard the traffic distribution
```

## Clean Up

```sh
k delete -f .
```