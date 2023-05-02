# Reactive Programming vs Reactive Systems

Reactive programming — focusing on computation through ephemeral dataflow chains — tends to be *event-driven*, while reactive systems — focusing on resilience and elasticity through the communication, and coordination, of distributed systems—is *message-driven* (also referred to as *messaging*).

When people talk about “reactive” in the context of software development and design, they generally mean one of three things:

- Reactive systems (architecture and design)
- Reactive programming (declarative event-based)
- Functional reactive programming (FRP)

## Reactive Programming

**Reactive Programming** is an asynchronous programming model where the flow is composed of observable sources and reactions to events without sacrifice. 
Is a programming paradigm that deals with asynchronous data streams and the propagation of changes in those streams. It allows you to build reactive and event-driven systems that can easily handle real-time data.

**Can be divided into two worlds:**

- **Event-loop** (I/O Reactor, Netty, AsyncHttp);

The event-loop model is based on the reactor pattern. The main idea behind this pattern is to have a handler (which in Node.js is represented by a callback function) associated with each I/O operation. When an event occurs, it is processed by the event loop, which invokes the appropriate handler to handle the event. In other words, The main idea behind the reactor pattern is to have a handler which will be invoked as soon as an event is produced and processed by the event loop.

- **Reactive-extensions** implementation (RxJava, Reactor, Mutiny);

The Reactive Extensions library extends the observer pattern and enables the composition of asynchronous and event-based programs. It lets you treat streams of asynchronous events with the same sort of simple, composable operations that you use for collections of data items, like arrays.

**Features:**

- **Publisher (Observable source, has a subscribe method)**
    - Multi(0 .. N or error) → can publish 0, error, or infinite events to its subscribers.
    - Single(0 .. 1 or error) → can publish 0, error, or 1 event to its subscribers
- **Lazy evaluation** (nothing happens until someone subscribes)
- **Hot vs Cold Publishers** → Hot Publishers do not create new data producers for each new subscription (as the Cold Publisher does). Instead, there will be only one data producer and all the observers listen to the data produced by the single data producer. So all the observers get the same data.
- **Schedulers →** allow you to control the threading and concurrency.

### **The Reactor Pattern**

The reactor pattern is one implementation technique of event-driven architecture. In simple terms, it uses a single-threaded event loop blocking on resource-emitting events and dispatches them to corresponding handlers and callbacks.

There is no need to block on I/O, as long as handlers and callbacks for events are registered to take care of them. Events refer to instances like a new incoming connection, ready for read, ready for write, etc.  Those handlers/callbacks may utilize a thread pool in multi-core environments.

This pattern decouples the modular application-level code from reusable reactor implementation.

There are two important participants in the architecture of Reactor Pattern:

**1. Reactor**

A Reactor runs in a separate thread, and its job is to react to IO events by dispatching the work to the appropriate handler. It’s like a telephone operator in a company who answers calls from clients and transfers the line to the appropriate contact.

**2. Handlers**

A Handler performs the actual work to be done with an I/O event, similar to the actual officer in the company the client wants to speak to.

A reactor responds to I/O events by dispatching the appropriate handler. Handlers perform non-blocking actions.

### Asynchronous Programming

**Reactive Programming is a subset of asynchronous programming** and a paradigm where the availability of new information drives the logic forward rather than having a control flow driven by a thread of execution.

**Asynchronous** is defined by the Oxford Dictionary as **“not existing or occurring at the same time,”** which in this context means that the processing of a message or event is happening at some arbitrary time, possibly in the future. This is a very important technique in reactive programming since it allows for non-blocking execution—where **threads of execution competing for a shared resource don’t need to wait by blocking** (preventing the thread of execution from performing other work until current work is done), **and can as such perform other useful work while the resource is occupied.** Amdahl’s Law tells us that contention is the biggest enemy of scalability, and therefore a reactive program should rarely, if ever, have to block.

### **Why do we need Asynchronous work?**

The simple answer is we want to improve the user experience. We want to make our application more responsive. We want to deliver a smooth user experience to our users without freezing the main thread, slowing them down and we don’t want to provide the jenky performance to our users.

To keep the main thread free we need to do a lot of heavy and time-consuming work we want to do in the background. We also want to do heavy work and complex calculations on our servers as mobile devices are not very powerful to do the heavy lifting. So we need asynchronous work for network operations.

**Reactive programming is generally *event-driven*, in contrast to reactive systems, which are *message-driven***

The application program interface (API) for reactive programming libraries are generally either:

- Callback-based—where anonymous side-effecting callbacks are attached to event sources, and are being invoked when events pass through the dataflow chain.
- Declarative—through functional composition, usually using well-established combinators like *map*, *filter*, *fold* etc.

The **primary benefits** of reactive programming are: **increased utilization of computing resources on multicore and multi-CPU hardware**; and increased performance by reducing serialization points and, by extension, Scalability Law.

When using reactive programming, **data streams** are going to be the spine of your application. Events, messages, calls, and even failures are going to be conveyed by a data stream. With reactive programming, you observe these streams and react when a value is emitted.

So, in your code, you are going to create data streams of anything and from anything: click events, HTTP requests, ingested messages, availability notifications, changes on a variable, cache events, measures from a sensor, literally anything that may change or happen. This has an interesting side-effect on your application: it’s becoming inherently asynchronous.

## Reactive System

***A reactive system* is an architectural style that allows multiple individual applications to coalesce as a single unit, reacting to its surroundings, while remaining aware of each other**—this could manifest as being able to scale up/down, load balancing, and even taking some of these steps proactively. It’s possible to write a single application in a reactive style (i.e. using reactive programming); however, that’s merely one piece of the puzzle. Though each of the above aspects may seem to qualify as “reactive,” in and of themselves they do not make a *system* reactive.

In a Reactive System, it’s the interaction between the individual parts that makes all the difference, which is the ability to operate individually yet act in concert to achieve their intended result.

**Messages have a clear (single) destination, while events are facts for others to observe**. Furthermore, messaging is preferably asynchronous, with the sending and the reception decoupled from the sender and receiver respectively.

Messages are needed to communicate across the network and form the basis for communication in distributed systems, while events on the other hand are emitted locally.

Reactive Systems are designed to be responsive, resilient, elastic, and message-driven. They are highly scalable and can handle a large number of requests and events in a timely and efficient manner. They are capable of processing a large number of events in parallel without blocking or slowing down the system. Reactive Systems are highly resilient and can recover quickly from failures.

**Examples/UseCases:**

- Netflix => Netflix uses a microservices architecture and is built using technologies like Kafka, RxJava, Hystrix, Eureka...

- Real-time Analytics

- Internet of Things (IoT)
