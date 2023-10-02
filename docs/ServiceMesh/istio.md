Istio is an open source service mesh that layers transparently onto existing distributed applications. Istio’s powerful features provide a uniform and more efficient way to secure, connect, and monitor services. Istio is the path to load balancing, service-to-service authentication, and monitoring – _with few or no service code changes_. Its powerful control plane brings vital features, including:

- Secure service-to-service communication in a cluster with TLS encryption, strong identity-based authentication and authorization
- Automatic load balancing for HTTP, gRPC, WebSocket, and TCP traffic
- Fine-grained control of traffic behavior with rich routing rules, retries, failovers, and fault injection
- A pluggable policy layer and configuration API supporting access controls, rate limits and quotas
- Automatic metrics, logs, and traces for all traffic within a cluster, including cluster ingress and egress

Istio is designed for extensibility and can handle a diverse range of deployment needs. Istio’s control plane runs on Kubernetes, and you can add applications deployed in that cluster to your mesh, extend the mesh to other clusters, or even connect VMs or other endpoints running outside of Kubernetes.

## Architecture Overview

An Istio service mesh is logically split into a **data plane** and a **control plane**.

- The **control plane** is responsible for **managing and configuring the data plane components**. It acts as the **centralized brain** of the service mesh. Key components within the control plane include:

      - **Istio Pilot**: Pilot is responsible for service discovery and traffic management. It collects and distributes configuration information to the Envoy proxies in the data plane.
      - **Istio Citadel**: Citadel manages security features like certificate issuance and rotation for service-to-service communication encryption.
      - **Istio Galley**: Galley validates and ingests configuration data, ensuring that it is correct and consistent before distributing it to other control plane components.

      The control plane's main responsibility is to configure and enforce policies for traffic routing, security, and observability across services in the mesh.

- The **data plane** is the **communication between services**. Without a service mesh, the network doesn’t understand the traffic being sent over, and can’t make any decisions based on what type of traffic it is, or who it is from or to. It's composed of a set of intelligent proxies (Envoy) deployed as sidecars, which run alongside each service instance in the mesh. These proxies **mediate and control all network communication between microservices** and also enforces policies defined in the control plane. They also collect and report telemetry on all mesh traffic. It plays a crucial role in:

      - **Load Balancing**: Envoy proxies perform intelligent load balancing and distribute traffic to service instances based on the routing rules defined in the control plane.
      - **Traffic Routing**: Envoy proxies follow routing rules and policies provided by the control plane to direct traffic to the appropriate service instances.
      - **Security**: Data plane proxies can enforce mTLS (mutual Transport Layer Security) and authentication policies to secure service-to-service communication.
      - **Telemetry and Observability**: Envoy collects telemetry data such as request/response metrics and sends them to monitoring tools (e.g., Prometheus, Grafana) for analysis and visualization.

The following diagram shows the different components that make up each plane:

![Istio Architecture](/Advanced-Journey/images/service-mesh/istio-architecture.png)

The flow of communication in an Istio-enabled service mesh works as follows:

1. When a client service/microservice/application wants to communicate with another service, it sends a request to its local Envoy proxy (the proxy deployed as a sidecar with the current service).
2. The local Envoy proxy checks with the control plane components (e.g., Pilot) to determine how to route the request based on service discovery and routing rules.
3. The Envoy proxy in the client's data plane handles the request according to the control plane's instructions, including load balancing and security policies.
4. The request is forwarded to the appropriate Envoy proxy in the target service's data plane.
5. The target service processes the request and sends a response, which follows a similar path back to the client through the data plane proxies.

## Envoy

Envoy is a high-performance proxy developed in C++ to mediate all inbound and outbound traffic for all services in the service mesh. Envoy proxies are the only Istio components that interact with data plane traffic.

Envoy proxies are deployed as sidecars to services, logically augmenting the services with Envoy’s many built-in features, for example:

- Dynamic service discovery
- Load balancing
- TLS termination
- HTTP/2 and gRPC proxies
- Circuit breakers
- Health checks
- Staged rollouts with %-based traffic split
- Fault injection
- Rich metrics

The sidecar proxy model also allows you to add Istio capabilities to an existing deployment without requiring you to rearchitect or rewrite code.

Some of the Istio features and tasks enabled by Envoy proxies include:

- Traffic control features: enforce fine-grained traffic control with rich routing rules for HTTP, gRPC, WebSocket, and TCP traffic.
- Network resiliency features: setup retries, failovers, circuit breakers, and fault injection.
- Security and authentication features: enforce security policies and enforce access control and rate limiting defined through the configuration API.
- Pluggable extensions model based on WebAssembly that allows for custom policy enforcement and telemetry generation for mesh traffic.

## Istiod

Istiod provides service discovery, configuration and certificate management.

Istiod converts high level routing rules that control traffic behavior into Envoy-specific configurations, and propagates them to the sidecars at runtime. Pilot abstracts platform-specific service discovery mechanisms and synthesizes them into a standard format that any sidecar conforming with the Envoy API can consume.

You can use Istio’s Traffic Management API to instruct Istiod to refine the Envoy configuration to exercise more granular control over the traffic in your service mesh.

Istiod security enables strong service-to-service and end-user authentication with built-in identity and credential management. You can use Istio to upgrade unencrypted traffic in the service mesh. Using Istio, operators can enforce policies based on service identity rather than on relatively unstable layer 3 or layer 4 network identifiers. Additionally, you can use Istio’s authorization feature to control who can access your services.

Istiod acts as a Certificate Authority (CA) and generates certificates to allow secure mTLS communication in the data plane.

## Traffic Management

Istio’s **traffic routing rules** let you easily control the flow of traffic and API calls between services. Istio simplifies configuration of service-level properties like circuit breakers, timeouts, and retries, and makes it easy to set up important tasks like A/B testing, canary rollouts, and staged rollouts with percentage-based traffic splits.

Istio’s traffic management model relies on the **Envoy proxies** that are deployed along with your services. All traffic that your mesh services send and receive (data plane traffic) is proxied through Envoy, making it easy to direct and control traffic around your mesh without making any changes to your services.

### Introducing Istio traffic management

In order to **direct traffic** within your mesh, Istio needs to know where all your endpoints are, and which services they belong to. To populate its own service registry, **Istio connects to a service discovery system**. For example, if you’ve installed Istio on a Kubernetes cluster, then Istio automatically detects the services and endpoints in that cluster.

Using this service registry, the **Envoy proxies can then direct traffic to the relevant services**. Most microservice-based applications have multiple instances of each service workload to handle service traffic, sometimes referred to as a load balancing pool. By default, the Envoy proxies distribute traffic across each service’s load balancing pool using a least requests model, where each request is routed to the host with fewer active requests from a random selection of two hosts from the pool; in this way the most heavily loaded host will not receive requests until it is no more loaded than any other host.

While Istio’s basic service discovery and load balancing gives you a working service mesh, it’s far from all that Istio can do. In many cases you might want more **fine-grained control over what happens to your mesh traffic**. You might want to direct a particular percentage of traffic to a new version of a service as part of A/B testing, or apply a different load balancing policy to traffic for a particular subset of service instances. You might also want to apply special rules to traffic coming into or out of your mesh, or add an external dependency of your mesh to the service registry. You can do all this and more by adding your own traffic configuration to Istio using Istio’s traffic management API.

The rest of this guide examines each of the traffic management API resources and what you can do with them. These resources are:

### Virtual services

A Virtual Service, along with destination rules, defines **how incoming traffic should be routed** to different versions or subsets of a service based on criteria such as HTTP headers, paths, or request attributes.
When a request arrives, Istio's Virtual Service component examines the request to determine the appropriate destination service and version.

With a virtual service, you can specify traffic behavior for one or more hostnames. You use routing rules in the virtual service that tell Envoy how to send the virtual service’s traffic to appropriate destinations. Route destinations can be different versions of the same service or entirely different services.

A **typical use case** is to send traffic to different versions of a service, specified as service subsets. Clients send requests to the virtual service host as if it was a single entity, and Envoy then routes the traffic to the different versions depending on the virtual service rules: for example, “20% of calls go to the new version” or “calls from these users go to version 2”. This allows you to, for instance, create a canary rollout where you gradually increase the percentage of traffic that’s sent to a new service version. The traffic routing is completely separate from the instance deployment, meaning that the number of instances implementing the new service version can scale up and down based on traffic load without referring to traffic routing at all. By contrast, container orchestration platforms like Kubernetes only support traffic distribution based on instance scaling, which quickly becomes complex.

- Address multiple application services through a single virtual service. If your mesh uses Kubernetes, for example, you can configure a virtual service to handle all services in a specific namespace. Mapping a single virtual service to multiple “real” services is particularly useful in facilitating turning a monolithic application into a composite service built out of distinct microservices without requiring the consumers of the service to adapt to the transition. Your routing rules can specify “calls to these URIs of monolith.com go to microservice A”, and so on. You can see how this works in one of our examples below.
- Configure traffic rules in combination with gateways to control ingress and egress traffic.

In some cases you also need to configure destination rules to use these features, as these are where you specify your service subsets. Specifying service subsets and other destination-specific policies in a separate object lets you reuse these cleanly between virtual services.

Example:

_The following virtual service routes requests to different versions of a service depending on whether the request comes from a particular user._

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
    - reviews # the virtual service is applied to any traffic destined for reviews service
  http:
    - match: # the following match clause matches requests with end-user header with value jason
        - headers:
            end-user:
              exact: jason
      route: # if the request matches the above match clause, it is routed to reviews:v2
        - destination:
            host: reviews
            subset: v2
    - route: # if the request doesn't match the above match clause, it is routed to reviews:v3
        - destination:
            host: reviews
            subset: v3 # the subset v3 of reviews service is defined in the destination rule
```

### Destination rules

Destination Rules **specify the traffic policies** (such as load balancing algorithms, circuit breakers, and mTLS settings) for a particular service or subset.
These rules are associated with a service and define how traffic should be handled at the destination.

You can think of virtual services as how you route your traffic to a given destination, and then you use destination rules to **configure what happens to traffic for that destination**. Destination rules are applied after virtual service routing rules are evaluated, so they apply to the traffic’s “real” destination.

In particular, you use destination rules to specify named service subsets, such as grouping all a given service’s instances by version. You can then use these service subsets in the routing rules of virtual services to control the traffic to different instances of your services.

Destination rules also let you customize Envoy’s traffic policies when calling the entire destination service or a particular service subset, such as your preferred load balancing model, TLS security mode, or circuit breaker settings.

Example:

_The following example destination rule configures three different subsets for the my-svc destination service, with different load balancing policies:_

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: my-destination-rule
spec:
  host: my-svc # the destination service
  trafficPolicy: # the traffic policy for the destination service
    loadBalancer:
      simple: RANDOM # the load balancing policy for the destination service
  subsets:
    - name: v1
      labels:
        version: v1
    - name: v2
      labels:
        version: v2
      trafficPolicy: # the load balancing policy for the v2 subset
        loadBalancer:
          simple: ROUND_ROBIN
    - name: v3
      labels:
        version: v3
```

### Gateways

You use a gateway to **manage inbound and outbound traffic for your mesh** (e.g., the internet or other networks), letting you specify **which traffic you want to enter or leave the mesh**. Gateway configurations are applied to standalone Envoy proxies that are running at the edge of the mesh, rather than sidecar Envoy proxies running alongside your service workloads.

Unlike other mechanisms for controlling traffic entering your systems, such as the Kubernetes Ingress APIs, Istio gateways let you use the full power and flexibility of Istio’s traffic routing. You can do this because Istio’s Gateway resource just lets you configure layer 4-6 load balancing properties such as ports to expose, TLS settings, and so on. Then instead of adding application-layer traffic routing (L7) to the same API resource, you bind a regular Istio virtual service to the gateway. This lets you basically manage gateway traffic like any other data plane traffic in an Istio mesh.

Gateways are primarily used to manage ingress traffic, but you can also configure egress gateways. An egress gateway lets you configure a dedicated exit node for the traffic leaving the mesh, letting you limit which services can or should access external networks, or to enable secure control of egress traffic to add security to your mesh, for example. You can also use a gateway to configure a purely internal proxy.

Example:

_The following example shows a possible gateway configuration for external HTTPS ingress traffic:_

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: ext-host-gwy
spec:
  selector:
    istio: ingressgateway # default gateway proxy deployment name
  servers:
    - port:
        number: 443
        name: https
        protocol: HTTPS
      hosts:
        - ext-host.example.com # the gateway is applied to requests with this host
      tls:
        mode: SIMPLE # # enables HTTPS on this port
        credentialName: ext-host-cert # name of the certificate, for example using cert-manager
```

This gateway configuration lets HTTPS traffic from ext-host.example.com into the mesh on port 443, but doesn’t specify any routing for the traffic.

To specify routing and for the gateway to work as intended, you must also **bind the gateway to a virtual service**. You do this using the virtual service’s gateways field, as shown in the following example:

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: virtual-svc
spec:
  hosts:
    - ext-host.example.com
  gateways:
    - ext-host-gwy
```

### Service entries

Service Entries allow you to **add external services or domains to the Istio service mesh**. These are typically used when your mesh needs to communicate with external services or legacy systems.
Service Entries specify how traffic should be routed to external services, including DNS resolution, protocol, and port details.

You use a service entry to **add an entry to the service registry that Istio maintains internally**. After you add the service entry, the Envoy proxies can send traffic to the service as if it was a service in your mesh. Configuring service entries allows you to **manage traffic for services running outside of the mesh**, including the following tasks:

- Redirect and forward traffic for external destinations, such as APIs consumed from the web, or traffic to services in legacy infrastructure.
- Define retry, timeout, and fault injection policies for external destinations.
- Run a mesh service in a Virtual Machine (VM) by adding VMs to your mesh.

You don’t need to add a service entry for every external service that you want your mesh services to use. By default, Istio configures the Envoy proxies to passthrough requests to unknown services. However, you can’t use Istio features to control the traffic to destinations that aren’t registered in the mesh.

Example:

_The following example mesh-external service entry adds the ext-svc.example.com external dependency to Istio’s service registry:_

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
  name: svc-entry
spec:
  hosts: # specify the external resource using the hosts field. You can qualify it fully or use a wildcard prefixed domain name.
    - ext-svc.example.com
  ports:
    - number: 443
      name: https
      protocol: HTTPS
  location: MESH_EXTERNAL
  resolution: DNS
```

You can configure virtual services and destination rules to control traffic to a service entry in a more granular way, in the same way you configure traffic for any other service in the mesh. For example, the following destination rule adjusts the TCP connection timeout for requests to the `ext-svc.example.com` external service that we configured using the service entry:

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: ext-res-dr
spec:
  host: ext-svc.example.com
  trafficPolicy:
    connectionPool:
      tcp:
        connectTimeout: 1s
```

### Sidecars

Sidecar proxies (typically Envoy) are deployed alongside each service instance within the mesh.
They **handle the actual routing of traffic within the mesh based on the rules and policies** defined by Virtual Services, Destination Rules, and other Istio components.
Sidecar proxies intercept incoming and outgoing traffic, making routing decisions based on the configuration provided by the control plane.

By default, Istio configures every Envoy proxy to accept traffic on all the ports of its associated workload, and to reach every workload in the mesh when forwarding traffic. You can use a sidecar configuration to do the following:

- Fine-tune the set of ports and protocols that an Envoy proxy accepts.
- Limit the set of services that the Envoy proxy can reach.

You might want to limit sidecar reachability like this in larger applications, where having every proxy configured to reach every other service in the mesh can potentially affect mesh performance due to high memory usage.

You can specify that you want a sidecar configuration to apply to all workloads in a particular namespace, or choose specific workloads using a `workloadSelector`. For example, the following sidecar configuration configures all services in the `bookinfo` namespace to only reach services running in the same namespace and the Istio control plane (needed by Istio’s egress and telemetry features):

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: Sidecar
metadata:
  name: default
  namespace: bookinfo
spec:
  egress: # configure egress traffic
    - hosts: # the hosts that the sidecar can reach
        - "./*" # all services in the same namespace
        - "istio-system/*" # the Istio control plane
```

See the Sidecar reference for more details.

### Traffic Flow When a Request Comes Into the Istio Service Mesh:

1. **Request Arrival**:
   - An external request (e.g., an HTTP request from a client) arrives at the Istio Gateway, which is configured to accept incoming traffic for a specific host and port.
2. **Gateway Processing**:
   - The Gateway examines the request and forwards it to the appropriate Virtual Service based on the host and port configuration.
3. **Virtual Service Routing**:
   - The Virtual Service, based on its rules and criteria (e.g., matching HTTP paths or headers), determines which destination service or subset should receive the traffic.
4. **Destination Rules Application**:
   - The Destination Rules associated with the selected destination service are consulted to apply traffic policies, such as load balancing, circuit breaking, or mTLS.
5. **Sidecar Proxy Handling**:
   - The Sidecar proxies (Envoy) for both the source and destination services are involved in routing the traffic.
   - The source-side Envoy proxy intercepts the outgoing traffic and applies any policies related to retries, timeouts, or authentication.
   - The destination-side Envoy proxy receives the incoming traffic and forwards it to the appropriate service instance based on load balancing rules.
6. **Service Execution**:
   - The target service processes the request and generates a response.
7. **Response Path**:
   - The response follows a similar path in reverse, going through the Sidecar proxies, adhering to policies set in Destination Rules and Virtual Services, and eventually returning to the client through the Gateway.

## How To - Examples

See the [examples/service-mesh/istio](https://github.com/GabrielBrotas/Advanced-Journey/tree/main/examples/service-mesh/istio) folder for examples on how to use Istio to manage traffic in your service mesh.
