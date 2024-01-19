# Microservices-based Architecture

## Differences between Microservice and Monolith

Microservices are ordinary applications, there isn't any difference from any other application.

The main difference are the goals, microservices has a well defined goal/domain and a monolith has all the ecosystem/responsability on the same system.

Microservices are part of an ecosystem, it isn't an isolated application, usually are part of a bigger context.

They are independent and communicate all the time directly or indirectly. 

Another big difference is the deployment process, microservices has less risk because the process is more independent.

Another difference is the team organization, we can have one team per microservice

## When to use

Monolith

- Start of a project
- POC - Proof of Concept
- When you don't understand the domains
- Ensure technology governance
- Easier to understand the code flow
- Everything on the same spot

Microservice

- Scale teams
- Well defined contexts / business rules/area
- Maturity in the delivery process
- Technical Maturity
- When you have the necessity of scale just one part of the system
- When you need different technologies

## Migration

- Context separation;
- Avoid excess granularity;
- Verify dependencies to avoid distributed monolith;
- Migrate databases;
- Think in events;
- Eventual consistency;
- CI/CD/Tests/Environments;
- Start from the edges, parts of the system that doesn't affect the main domain;

## Resiliency

- Health Check
- Rate Limiting
- Circuit breaker
- API Gateway
- Service Mesh
- Retry
- Transactional Outbox

    Temporary table, is a local queue;

    First we save the message on this table and then we send the message to kafka, if the message was sent successfully we delete the message from the Outbox table, but, if some error happen to send the message to kafka we know that it'll be secure in our db

- Fallback policies
- Observability
- Idempotency - deal with duplicated messages


**Complex Situations:**

- What if the message broker goes down? how the system should behave?
- It will have message loss?

Exponential backoff and Jitter: [https://aws.amazon.com/pt/blogs/architecture/exponential-backoff-and-jitter/](https://aws.amazon.com/pt/blogs/architecture/exponential-backoff-and-jitter/)

OTEL - [https://opentelemetry.io/](https://opentelemetry.io/)

## Choreography vs Orchestration

A choreographed system uses by definition event-driven communication, whereas microservice orchestration uses command-driven communication. An event is something which happened in the past and is a fact. The sender does not know who picks up the event or what happens next. An example can be the event “Credit checked.”

**Choreography**

All microservices talks to each other, there isn't a master service to orchestrate the communication, if service A needs something from service C it will talk directly.

- **Loose coupling:** Choreography allows microservices to be loosely coupled, which means they can operate independently and asynchronously without depending on a central coordinator. This can make the system more scalable and resilient, as the failure of one microservice will not necessarily affect the other microservices.
- **Ease of maintenance:** Choreography allows microservices to be developed and maintained independently, which can make it easier to update and evolve the system.
- **Decentralized control:** Choreography allows control to be decentralized, which can make the system more resilient and less prone to failure.
- **Asynchronous communication:** Choreography allows microservices to communicate asynchronously, which can be more efficient and scalable than synchronous communication.

**Orchestration**

Has a "maestro" that control the moment where each step/service will execute.

When talking about orchestration you can picture a big orchestra which features multiple instruments and a conductor who makes sure that everyone stays in tact. He tells when which instrument needs to play to ensure that the song sounds as it should like.

- **Simplicity:** Orchestration can be simpler to implement and maintain than choreography, as it relies on a central coordinator to manage and coordinate the interactions between the microservices.
- **Centralized control:** With a central coordinator, it is easier to monitor and manage the interactions between the microservices in an orchestrated system.
- **Visibility:** Orchestration allows for a holistic view of the system, as the central coordinator has visibility into all of the interactions between the microservices.
- **Ease of troubleshooting:** With a central coordinator, it is easier to troubleshoot issues in an orchestrated system.

## DURS Principle

Each service can be independently DURS (deployed, updated, replaced, and scaled)

- *Microservice*
- *Domain-Driven Design*
- *Failure Isolation*
- *Continuous Delivery*
- *Decentralization*
- *DevOps*
- *Scalability*
- *Resilience*

## Failure Isolation

- What happens when that request fails?
- What is our average response time on that request?
- What would our support team change about the user experience?

The microservices architecture moves application logic to services and uses a network layer to communicate between them. Communicating over a network instead of in-memory calls brings extra latency and complexity to the system which requires cooperation between multiple physical and logical components. The increased complexity of the distributed system leads to a higher chance of particular **network failures.**

One of the biggest advantage of a microservices architecture over a monolithic one is that teams can independently design, develop and deploy their services. They have full ownership over their service’s lifecycle. It also means that teams have no control over their service dependencies as it’s more likely managed by a different team. With a microservices architecture, we need to keep in mind that provider **services can be temporarily unavailable** by broken releases, configurations, and other changes as they are controlled by someone else and components move independently from each other.

### Strategies: 

- **Automatic Rollouts**

    In a microservices architecture, services depend on each other. This is why you should minimize failures and limit their negative effect. To deal with issues from changes, you can implement change management strategies and **automatic rollouts**.

    For example, when you deploy new code, or you change some configuration, you should apply these changes to a subset of your instances gradually, monitor them and even automatically revert the deployment if you see that it has a negative effect on your key metrics.

    Another solution could be that you run two production environments. You always deploy to only one of them, and you only point your load balancer to the new one after you verified that the new version works as it is expected. This is called blue-green, or red-black deployment.

- **Health-check and Load balancing**

    Instances continuously start, restart and stop because of failures, deployments or autoscaling. It makes them temporarily or permanently unavailable. To avoid issues, your load balancer should **skip unhealthy instances** from the routing as they cannot serve your customers’ or sub-systems’ need.

    Application instance health can be determined via external observation. You can do it with repeatedly calling a `GET /health` endpoint or via self-reporting. Modern **service discovery** solutions continuously collect health information from instances and configure the load-balancer to route traffic only to healthy components.

More:

- [designing-microservices-architecture-for-failure](https://blog.risingstack.com/designing-microservices-architecture-for-failure/)