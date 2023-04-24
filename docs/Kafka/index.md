# Apache Kafka

Open source project created by Apache foundation

> Apache Kafka is an open-source distributed event streaming platform used by thousands of companies for high-performance data pipelines, streaming analytics, data integration, and mission-critical applications.
> 

Nowadays everything is based on events, and we have to get these events to understand what happen and deal with the data in the most properly way.

**Questions**

- Where do I save these events?
- How can I restore in a fast and simple way these events so that the feedback between one process and another can happen in a fluidly way and in real time?
- How to scale?
- How can I have resilience and high availability?

**Kafka "Super Powers"**

- High throughput. can handle thousands of events per second;
- Low latency (2ms);
- Scalable;
- High Storage;
- High availability;
- It can connect with almost everything (Go, Node, Python,…);
- Has a lot of libraries that makes easy to work with Kafka;
- Open source;

---

## How it works

```md										
                                          [Broker A]
[Producer] -- Data --> [Apache Kafka] --> [Broker B] <-- data -- [Consumer]
										  [Broker C]
```

Kafka is a cluster, and this cluster is formed by a set of nodes and these nodes are our brokers;

**Producer** ⇒ Publish messages;

**Consumer** ⇒ Consume the message, will access the broker to read the messages;

**Broker** ⇒ Each broker has its own database, each broker is a machine, and the node responsability is just to store the data;

Kafka doesn’t send message to anyone, Kafka just stores the message and the consumer read/retrieve the data;

Usually when you deploy a cluster the recommendation is to have at least 3 brokers;

These brokers communicate all the time and in order to manage this communication and to see what nodes are available or not the Kafka has another service called **zookeper** that can work as a service discovery, load balancer and so on…

## Managed Services

- Confluent Cloud → the most complete enviroment (Expensive)
- Amazon MSK (Managed Streaming for Apache Kafka) → (Expensive) Lowest price = $2.5/day
- Aiven Kafka
- ...
