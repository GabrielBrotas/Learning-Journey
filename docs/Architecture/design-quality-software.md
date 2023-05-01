# Designing Quality Software

## Performance
When it comes to developing software, performance is an essential factor. It's the software's ability to complete a specific workload. But how can we determine how well a software performs a particular action? To measure performance, we need data. The primary units of measurement for evaluating software performance are latency and throughput.

The units of measurement for evaluating software performance are:

- Latency or "response time" ⇒ Time it takes for a software application to process a request and complete a workload.
- Throughput ⇒ Number of requests a software application can handle.

Having a performative software is different from having a scalable software

Objective:

- Reduce latency, usually measured in milliseconds; It is affected by the application's processing time, network, and external calls;
- Increase throughput, allow the software to handle more requests; It is directly linked to latency;

**Main reasons for low performance:**

- Inefficient processing;
    - Ex: Algorithms, the way the application is handling data, poorly made queries, etc.
- Limited computational resources;
    - CPU, RAM, Memory,...
- Working in a blocking way;
    - Every time you make a request and if that request blocks the application to deal specifically with that request, the application will decrease throughput because it will not be able to handle thousands of requests in parallel.
    - Separate each request into a thread.
- Serial access to resources;
    - Every time you access an API you wait for it to finish and call the next one, one after the other, this decreases throughput.

**Main ways to increase efficiency:**

- Scale of computational capacity (CPU, Disk, Memory, Network);
- Logic behind the software (Algorithms, queries, framework overhead);
- Concurrency and parallelism; Dealing with multiple processes at the same time;
- Databases (types of databases, schema);
- Caching;


**Computational Capacity: Vertical Scale vs Horizontal Scale**

- Vertical Scale ⇒ Increase the computational capacity of the machine, so that the application can receive more requests;

- Horizontal Scale ⇒ Increase the number of machines by placing a load balancer in front to balance the loads;

**Concurrency and Parallelism**

"Concurrency is about dealing with many things at once. Parallelism is about doing many things at once."

- **Concurrency ⇒** Deals with several things but they are not necessarily executed at the same time; When two or more tasks can start to be executed and finish in overlapping time periods, not meaning that they need to be in execution necessarily at the same time.

    That is, you have concurrency when:

    - More than one task progresses at the same time in an environment with multiple CPUs/cores;

    - Or in the case of a single-core environment, two or more tasks may not progress at the exact same moment, but more than one task is processed in the same time interval, not waiting for one task to complete before starting another.

- **Parallelism ⇒** Perform actions simultaneously. It happens when two or more tasks are executed, literally, at the same time. Obviously requires a processor with multiple cores, or multiple processors so that more than one process or thread can be executed simultaneously.

Imagining a web server with a worker:

**Serial way**
- Working in a serial way - single process
- Serving 5 requests

If the worker operates in serial mode, it will attend to one request at a time.

```docker
10ms -> 10ms -> 10ms -> 10ms -> 10ms 
------------------------------------
              50ms
```

**Concurrent/parallel way**
- 5 threads serving 1 request each

If it operates in parallel mode, it can handle multiple requests simultaneously, which improves its performance.

```docker
10 ms ->
10 ms ->
10 ms ->
10 ms ->
10 ms ->
--------
  10ms
```

---

## Caching

Fetching things that have been processed before and returning them more quickly to the end user.

- **Edge caching / Edge computing**

    The user does not hit the machine (ec2, ecs, lambda,...) because this type of cache will cache the data on an edge that is before the main server.
    Examples of services: Cloudflare, Cloudfront.
    
    Cloudfront caches static files (images, css, js, ...) in an availability zone and users who are close to them will receive the data almost instantly.

    Types of edge cache:

    - Static data;
    - Web pages;
    - Internal functions;
        - Avoid reprocessing heavy algorithms by setting a TTL of 30min, for example;
        - Access to the database (avoid unnecessary I/O).
    - Objects;


    **Problem:** Netflix has millions of accesses to its web application, if the data center is in the United States, users from all over the world will have to travel from their location to the USA to get these terabytes of data in order to access the site, congesting Netflix's network and the internet in general and generating a lot of latency to access content.
    
    **Solution: Edge computing:**  caching this data in the regions where your users are located, avoiding users having to travel across the entire internet to hit the data center. It will give a better experience to the user (low latency) and we will pay less because we will have fewer requests on our servers.
    
    - Cache performed closer to the user. The user does not need to hit the USA to get an image.
    - Avoids the request reaching the Cloud Provider / Infra.
    - Usually static files. (Cheaper, faster)
    - CDN - Content Delivery Network; (Network of servers, spreads your content to other data centers), e.g: Akamai's CDN → More than 500 points in Brazil, spreads your content (videos) to the regions of Brazil.
        If you're in Portugal, your video should be loaded from a CDN in Portugal.
        Cost:
        - CDN cost
        - Distribution cost: If Akamai does not have the video/image on its CDN, it will fetch the content from the server (e.g: us-east-1), download it and make it available to you. Once it has been downloaded, it will perform something called Midgress, which means that it will now take that content and distribute it among strategic points, and this content spreading consumes bandwidth, which you pay for to spread across the edges. Origin → CDN → midgress →...
    - Cloudflare workers ⇒ Edge computing platform
    - Vercel
    - Akamai

## **Scalability**

Scalability is the ability of systems to support an increase (or decrease) in workloads by incrementing (or reducing) the cost in equal or lesser proportion.

While performance focuses on reducing latency and increasing throughput, scalability aims to have the possibility of increasing or decreasing throughput by adding or removing computational capacity.

Vertical Scaling - Horizontal Scaling

**Scaling Software - Decentralization**

Machines are disposable, so your system must be independent of the machine being used.

- **Ephemeral Disk →** Everything you save on disk can be deleted when needed. We need the power to kill the machine when we want to.
- **Application Server vs Assets Server →** Server has the application code, assets are on an assets server (s3 bucket).
- **Centralized Cache →** The cache is not on the machine itself, it is on a server specific for caching. ex: DynamoDB.
- **Centralized Sessions →** The software cannot store state.
- **Upload / File Writing →** Bucket / file server

Everything can be easily destroyed and created.

**Scaling Databases**

- Increasing computational resources; More disk, memory, cpu,...;
- Distributing responsibilities (write vs read); Create replicas;
- Sharding horizontally; Create multiple read machines;
- Query and index optimization;
- Serverless / Cloud databases; (Dynamo, Aurora, Fauna,...);

Use an APM (Application performance monitoring) system to identify bottlenecks in queries and problems that are occurring.

- Explain in queries → identify what is happening in queries
- CQRS (Command Query Responsibility Segregation)

**Reverse Proxy**

Proxy = Proxy, a person who speaks on your behalf

Redirects users;

A proxy is a service that routes traffic between the client and another system. It can regulate traffic according to present policies, enforce security, and block unknown IPs.

A reverse proxy is a server that sits in front of all servers, it has rules, and these rules cause it to forward your request to certain servers that can resolve it. Unlike a normal proxy, which sits on the client side, the reverse proxy is designed to protect the servers. It accepts the client's request and forwards the request to one or more servers and returns the processed result. The client communicates directly with the reverse proxy and does not know about the server that processed it.

**Reverse Proxy Solution:**

- Nginx
- HAProxy (HA = High Availability)
- Traefik

## **Resilience**

It is a set of intentionally adopted strategies for adapting a system when a failure occurs.

In software, if an error occurs, it either throws an exception or has a strategy to serve the client request, even if partially, despite the error.

Resilience is the power to adapt if something happens.

How can I register a user even if the Correios API is not working to get the ZIP code? How can I get that sale if my payment service is not working?

The only thing we are certain of is that our software will fail at some point, but we must have resilience to deal with these failures.

Having resilience strategies allows us to minimize the risks of data loss and important business transactions.

### Resilience Strategies

- **Protect and be Protected**
    
    It is very common today for an application to be based on an ecosystem with several other services. A system in a distributed architecture needs to adopt self-preservation mechanisms to ensure its operation with the highest possible quality.
    
    A system cannot be "selfish" to the point of making more requests on a system that is failing.
    
    **Example:**
    
    System A sending a request to know the price table for System B, but System B does not respond, and System A keeps sending several requests in succession, eventually System B will go offline.
    
    So, a system cannot keep sending multiple requests to another until it crashes, it is no use kicking a dead dog.
    
    A slow system online is often worse than a system offline. (Domino effect).
    
    **Example:**
    
    System A calls System B that calls System C, if System C is slow, it will delay B's response, which will consequently delay A's response, and if more requests are coming, it will end up crashing some service and eventually maybe all.
    
    So, sometimes if a system is not handling requests, it is better to return 500 for everyone until it stabilizes again.
    
    One form of protection is to identify that you cannot handle requests or that the other service is no longer able to handle them or taking too long to respond.
    
- **Health Check**
    
    Check the application's health;
    
    "Without vital signs, it is not possible to know the health of a system".
    
    Important to know if it is able to receive requests or not, ..., if it is bad, it already returns a 500 error for the other applications to know if it is unavailable.
    
    An unhealthy system has a chance to recover if traffic stops being directed to it temporarily.
    
    Self-healing, give the server time to self-recover, stop sending requests to it.
    
    **Quality Health Check**, usually people only put a /health route to check if the application is healthy, but this cannot measure if the application is really healthy because in the other routes, there is usually processing, database query, data formatting, etc.
    
- **Rate Limiting**
    
    Protects the system based on what it was designed to support.
    
    To know this limit, we can do stress testing and/or the company's budget to know how much traffic it can handle.
    
    **Example:** 100 requests per second, "it's as much as I can handle", returns a 500 error if exceeded.
    
    We can also work with priority, reserve 60 requests for an important client and 40 for the rest.

- **Circuit breaker**
    
    It protects the system by denying requests made to it. Example: 500
    
    If the API is having problems, the circuit opens the "switch" and no longer allows requests to pass through.
    
    **Closed Circuit =** Requests arrive normally;
    
    **Open Circuit** = Requests do not reach the system. Instant error to the client;
    
    **Half-open** = Allows a limited number of requests to verify if the system can fully come back online.
    
- **API Gateway**
    
    Centralizes the receipt of all application requests, all requests pass through it and it applies the policy/validation rules before forwarding the request to the resolver.
    
    It understands the individual needs of each application.
    
    Ensures that "inappropriate" requests reach the system:
    
    Example: Unauthenticated user.
    
    We take the authentication responsibility away from the application and pass it to the API Gateway, just by doing that we already reduce the resource expense to check whether the user is authenticated or not.
    
    It's like living in a condominium and the person can only enter the apartment if they go through the gatehouse (API Gateway) first.
    
    Implements policies such as Rate Limiting, Health check, etc...
    
    Example of services: Kong
    
- **Service mesh**
    
    Controls network traffic.
    
    Instead of services communicating directly with each other, they hit a proxy called a sidecar and that sidecar sends the request to the sidecar of another system.
    
    ```
    [ System A ] (Sidecar) ----> (Sidecar) [System B]
    ```
    
    All network communication is performed via proxy, so everything that is passing on the network can be controlled.
    
    Avoids protection implementations by the system itself.
    
    You can analyze everything that is happening on the network, all traffic, and with that you can define the rules for Rate Limiter, Circuit Breaker, etc...
    
    mTLS → encrypt the network to ensure that Service A is itself and B is itself.
    
- **Asynchronous communication**
    
    With less computational resources, it can handle more computational resources than it could otherwise.
    
    It does not need to deliver the response to the requests immediately.
    
    Avoids data loss;
    
    There is no data loss in sending a transaction if the server is down;
    
    **Example:** synchronously, if we make a payment and the server is not available, it will tell us to try again later, however, asynchronously allows us to send the message/information to an intermediary (Redis, RabbitMQ, AWS SNS, Kafka, ...) to handle the action because the other end does not need the response at that moment.
    
    The server can process the transaction in its own time when it is online;
    
- **Delivery guarantees with Retry**
    
    When we want resilience in the request, we need to make sure that the message we are sending is reaching its destination, but not always the message can reach its destination because the other system may be slow, offline, ... and because of that one of the ways to have resilience and minimize this problem is to have Retry policies, send a message, if the system does not respond, send another, and another, ...
    
    But we have a **problem**, if 10 services send a request and the server cannot handle 10 simultaneous requests, even if the other servers have retry policies and keep sending messages every 2 seconds, it will not help because they are all trying to access the server at the same time and will always return an error.

    To do this, we have the **Exponential backoff - Jitter**, where we wait exponentially 2s, 4s, 8s, 16s, etc., to give the server more time to recover, and with Jitter, it has an algorithm that adds random noise to requests so that they do not happen simultaneously. For example, (2.1s, 2.5s, 2.0s), (4.7s, 4.01s, 4.12s), etc., so that even if services are sending requests simultaneously, the noise will make them arrive differently.

- **Delivery guarantees with Kafka**
- **Complex situations**
    - What happens if the message broker goes down? (Kafka, RabbitMQ, SNS, etc.)
    - Will messages be lost?
    - Will your system be down?
    - How to ensure resilience in unusual situations?
    
    There are always some Single Points of Failure (SPF).
    
    For example, if all the resilience you rely on is in Apache Kafka, it means that your SPF is in Apache Kafka.
    
    How can we avoid this, so that if Kafka goes down, the system does not lose information?
    
    All of this involves risk management, and the more resilience we guarantee, the more expensive it will be for the company.
    
    If AWS goes down? Is it worth working with multi-cloud?
    
    There will always be a limit to your resilience, and the more resilience, the more effort and cost.
    
    The responsibility for defining the level of resilience of the system lies with the CTO / CEO, who defines the risk that it will generate for the business.