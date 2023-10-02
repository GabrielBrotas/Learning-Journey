# Service Mesh

## What is a service mesh?

A service mesh is a dedicated **infrastructure layer that controls service-to-service communication over a network**. This method enables separate parts of an application to communicate with each other.

A service mesh controls the **delivery of service requests** in an application. Common features provided by a service mesh include service discovery, load balancing, encryption and failure recovery. Service meshes can make service-to-service communication fast, reliable and secure.

This visible infrastructure layer can document how well (or not) different parts of an app interact, so it becomes easier to optimize communication and avoid downtime as an app grows.

Moden applications are often built using a microservices architecture, where each service performs a specific business function and it might need to request data from several other services. But what if some services get overloaded with requests? This is where a service mesh comes in - it routes requests from one service to the next, optimizing how all the moving parts work together.

## How a service mesh works

In a microservice application, a **sidecar** attaches to each service. In a container, the sidecar attaches to each application container, VM or container orchestration unit, such as a Kubernetes pod.

Sidecars can handle tasks abstracted from the service itself, such as monitoring and security. In a service mesh, each microservice is deployed with a lightweight network proxy (sidecar). **The sidecar proxy sits alongside the microservice and manages all incoming and outgoing traffic for that service**. Common sidecar proxy implementations include Envoy, Istio Proxy, and Linkerd's proxy.

Service instances, sidecars and their interactions make up what is called the data plane in a service mesh. A different layer called the control plane manages tasks such as creating instances, monitoring and implementing policies for network management and security. Control planes can connect to a CLI or a GUI interface for application management.

Without a service mesh, each microservice needs to be coded with logic to govern service-to-service communication, which means developers are less focused on business goals. It also means communication failures are harder to diagnose because the logic that governs interservice communication is hidden within each service.

## Why adopt a service mesh?

An application structured in a microservices architecture might comprise dozens or hundreds of services, all with their own instances that operate in a live environment. It's a big challenge for developers to keep track of which components must interact, monitor their health and performance and make changes to a service or component if something goes wrong.

A service mesh enables developers to **separate and manage service-to-service communications in a dedicated infrastructure layer**. As the number of microservices involved with an application increases, so do the benefits of using a service mesh to manage and monitor them. That’s because a service mesh also captures every aspect of service-to-service communication as performance metrics. Over time, data made visible by the service mesh can be applied to the rules for interservice communication, resulting in more efficient and reliable service requests.

For example, If a given service fails, a service mesh can collect data on how long it took before a retry succeeded. As data on failure times for a given service aggregates, rules can be written to determine the optimal wait time before retrying that service, ensuring that the system does not become overburdened by unnecessary retries.

## Key features of a service mesh

A service mesh framework typically provides many capabilities that make containerized and microservices communications more reliable, secure and observable.

- **Reliability**: Managing communications through sidecar proxies and the control plane improves efficiency and reliability of service requests, policies and configurations. Specific capabilities include load balancing and fault injection.

- **Observability**: Service mesh frameworks can provide insights into the behavior and health of services. The control plane can collect and aggregate telemetry data from component interactions to determine service health, such as traffic and latency, distributed tracing and access logs. Third-party integration with tools, such as Prometheus, Elasticsearch and Grafana, enables further monitoring and visualization.

- **Security**: Service mesh can automatically encrypt communications and distribute security policies, including authentication and authorization, from the network to the application and individual microservices. Centrally managing security policies through the control plane and sidecar proxies helps keep up with increasingly complex connections within and between distributed applications. Additionally, it provides features like mutual TLS (mTLS) encryption between services, role-based access control (RBAC), and the ability to enforce security policies at the network level.

- **Service Discovery**: Service meshes typically integrate with service discovery mechanisms, such as Kubernetes DNS or etcd, to maintain an up-to-date list of available services and their locations. This enables automatic discovery and routing to services.

- **Traffic Routing**: The sidecar proxy controls the routing of traffic between microservices. It intercepts incoming requests and forwards them to the appropriate destination based on routing rules defined in the service mesh configuration. These routing rules can be based on service names, versions, or custom criteria.

- **Load Balancing**: Service mesh proxies can implement various load balancing algorithms to distribute incoming requests evenly among multiple instances of a service. This helps optimize resource utilization and improve application performance.

- **Service-to-Service Communication**: When one microservice needs to communicate with another, it sends its requests to the local sidecar proxy. The sidecar proxy, based on the routing rules, forwards the request to the destination service's sidecar proxy, effectively establishing secure and reliable communication between services.

- **Traffic Control and Policies**: Service meshes provide fine-grained traffic control and policy enforcement capabilities. You can configure features like retries, circuit breaking, timeouts, rate limiting, and security policies like authentication and authorization. These policies help improve the reliability and security of microservices communication.

- **Observability**: Service meshes collect telemetry data about the communication between services, including metrics, traces, and logs. This data is often sent to observability tools like Prometheus, Grafana, Jaeger, or Zipkin. Operators and developers can use these tools to monitor and troubleshoot application performance and errors.

## Service mesh benefits and drawbacks

A service mesh addresses some large issues with managing service-to-service communication, but not all. Some advantages of a service mesh are as follows:

- Simplifies communication between services in both microservices and containers.
- Easier to diagnose communication errors, because they would occur on their own infrastructure layer.
- Supports security features such as encryption, authentication and authorization.
- Allows for faster development, testing and deployment of an application.
- Sidecars placed next to a container cluster is effective in managing network services.

Some downsides to service mesh are as follows:

- Runtime instances increase through use of a service mesh.
- Each service call must first run through the sidecar proxy, which adds a step and can add some latency to requests, although this is typically minimal. Overusing features like mTLS can also impact latency.
- Operational Overhead. Network management complexity is abstracted and centralized, but not eliminated -- someone must integrate service mesh into workflows and manage its configuration.
- Complexity and Learning Curve
- The deployment of additional proxy sidecars and observability tools can lead to increased infrastructure costs.

## Popular service mesh implementations

- Istio
- Consul
- AWS App Mesh
- Linkerd

## Refs

- [TechTarget-definition-service-mesh](https://www.techtarget.com/searchitoperations/definition/service-mesh)
- [RedHat-what-is-a-service-mesh](https://www.redhat.com/en/topics/microservices/what-is-a-service-mesh)
