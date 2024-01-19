# Characteristics

## Componentization via Services

- **component** is a unit of software that is independently replaceable and upgradeable.
- **libraries** are linked into a program and called using in-memory function calls, while **services** are out-of-process components who communicate with a mechanism such as a web service request, or remote procedure call.
- **Services** are independently deployable and scalable, which means that they can be deployed and started, or restarted, independently of other services.
- **Services** are also independently replaceable, which means that a new version of a service can be deployed alongside the old version, and traffic can be routed between them.

## Organized around Business Capabilities

- **Microservices** are organized around business capabilities, which means that each service is responsible for a single capability, and that all of the code and data for that capability is encapsulated within the service.
- "Any organization that designs a system (defined broadly) will produce a design whose structure is a copy of the organization's communication structure." in other words, usually, we structure our software based on the structure of our organization. However, when we start to develop a microservices architecture, we need to think about the **business capabilities** that we want to deliver to our customers, and then organize our software around those capabilities.
- For example, if we are building an e-commerce application, we might have services for product search, product recommendations, product reviews, product ratings, shopping cart, checkout, and payment processing. Each of these services would be responsible for a single capability, and for each service we would have a separate team of developers.

- How big is a microservice?
    - The largest sizes reported follow Amazon's notion of the Two Pizza Team (i.e. the whole team can be fed by two pizzas), meaning no more than a dozen people. On the smaller size scale we've seen setups where a team of half-a-dozen would support half-a-dozen services.

## Products not Projects

- **Microservices** are products, not projects, which means that they are long-lived, and evolve over time.
- Most application development efforts use a **project model**: where the aim is to deliver some piece of software which is then considered to be completed. On completion the software is handed over to a maintenance organization and the project team that built it is disbanded.
- Microservice proponents tend to avoid this model, preferring instead the notion that a **team should own a product over its full lifetime**.
- "You build, you run it" is a common mantra in the microservice world, meaning that a development team takes full responsibility for the software in production. This brings developers into day-to-day contact with how their software behaves in production and increases contact with their users, as they have to take on at least some of the support burden.
- Rather than looking at the software as a set of functionality to be completed, there is an on-going relationship where the question is how can software assist its users to enhance the business capability.

## Smart endpoints and dumb pipes

- When building communication structures between different processes, we've seen many products and approaches that **stress putting significant smarts into the communication mechanism itself**. A good example of this is the Enterprise Service Bus (ESB), where ESB products often include sophisticated facilities for message routing, choreography, transformation, and applying business rules.
- The microservice community favours an alternative approach: **smart endpoints and dumb pipes**. Applications built from microservices aim to be as decoupled and as cohesive as possible - they own their own domain logic and act more as filters in the classical Unix sense - receiving a request, applying logic as appropriate and producing a response. 
- **Microservices** use technology agnostic protocols for communication between services, and implement business logic in services rather than in the transport.
- The communication channel should not have business logic embedded in it. It should be a dumb pipe that can transport messages from one service to another. The business logic should be in the service itself.
- when the communication channel is smart, it becomes difficult to change the business logic because it is embedded in the communication channel and we end up creating a coupling between the business logic and the communication channel.

## Decentralized Governance

- One of the consequences of centralised governance is the tendency to standardise on single technology platforms. However, not every problem is a nail and not every solution a hammer.
- Splitting the monolith's components out into services we have a choice when building each of them. Use right tool for the job. Of course, just because you can do something, doesn't mean you should - but partitioning your system in this way means you have the option.
- Executing consumer driven contracts as part of your build increases confidence and provides fast feedback on wheter your services are functioning.

## Decentralized Data Management

- "the conceptual model of the world will differ between systems." This is a common issue when integrating across a large enterprise, the sales view of a customer will differ from the support view. Some things that are called customers in the sales view may not appear at all in the support view. Those that do may have different attributes and (worse) common attributes with subtly different semantics.
- A useful way of thinking about this is the **Domain-Driven Design** notion of **Bounded Context**. DDD divides a complex domain up into multiple bounded contexts and maps out the relationships between them.
- As well as decentralizing decisions about conceptual models, microservices also decentralize data storage decisions.
- Distributed transactions are notoriously difficult to implement and as a consequence microservice architectures emphasize transactionless coordination between services, with explicit recognition that consistency may only be eventual consistency and problems are dealt with by compensating operations.

## Infrastructure Automation

- We want as much confidence as possible that our software is working, so we run lots of **automated tests**. Promotion of working software 'up' the pipeline means we **automate deployment** to each new environment.
- Regardess of the tool (e.g. terraform, ansible, github-actions, etc), the goal is to have an automated process that can deploy the software the environments.
    - example: compile, unit and funcional tests -> acceptance test -> integration test -> user acceptance test -> performance test -> deploy production

## Design for failure

- A consequence of using services as components, is that applications need to be designed so that **they can tolerate the failure of services**.
- Any service call could fail due to unavailability of the supplier, the client has to respond to this as gracefully as possible. -- This is a disadvantage compared to a monolithic design as it introduces additional complexity to handle it.
- The consequence is that microservice teams constantly reflect on how service failures affect the user experience.
- Since services can fail at any time, it's important to be able to detect the failures quickly and, if possible, automatically restore service. Microservice applications put a lot of emphasis on real-time monitoring of the application, checking both architectural elements (how many requests per second is the database getting) and business relevant metrics (such as how many orders per minute are received). Semantic monitoring can provide an early warning system of something going wrong that triggers development teams to follow up and investigate.
- Microservice teams would expect to see sophisticated monitoring and logging setups for each individual service such as dashboards showing up/down status and a variety of operational and business relevant metrics. Details on circuit breaker status, current throughput and latency are other examples we often encounter in the wild.

## Evolutionary Design

- The key property of a component is the notion of independent replacement and upgradeability, which implies we look for points where we can imagine rewriting a component without affecting its collaborators.
- You want to keep things that change at the same time in the same module. Parts of a system that change rarely should be in different services to those that are currently undergoing lots of churn. If you find yourself repeatedly changing two services together, that's a sign that they should be merged.
- the preference in the microservice world is to only use versioning as a last resort. We can avoid a lot of versioning by designing services to be as tolerant as possible to changes in their suppliers.
- When applying evolutionary design it is important to keep the design as clean as possible at all times. This means that you need to keep your code well factored, with a good set of automated tests. This allows you to make changes quickly and safely, and prevents the code from rotting.

## Trade-Offs

| Pros | Cons |
| ---- | ---- |
| Strong Module Boundaries | Distribution |
| Independent Deployment | Eventual Consistency |
| Technology Diversity | Operational Complexity |

## Refs

- [martinfowler-componentization](www.martinfowler.com/articles/microservices.html#ComponentizationViaServices)