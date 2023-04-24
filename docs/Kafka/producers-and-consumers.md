## Producer

Responsible for producing messages for a specific topic.


### Delivery Guarantee
```jsx
[Producer] ----> [Broker A][Topic A] Leader
				 [Broker B][Topic A] Follower
				 [Broker C][Topic A] Follwer
```

The Producer will alwasy send the message to the leader broker first.

**Acks:**
The acks setting specifies acknowledgements that the producer requires the leader to receive before considering a request complete.

- **[Ack 0, None]** → Acknowledge 0, None, AKA FF (Fire and Forget)
    - It’s the fastest way to send messages because Kafka doesn’t waste time responding to the user so it can handle way more transactions
    - Uber usecase: The driver send his location every 10 seconds, this location is sent to Kafka to handle that message, if Kafka loses 2 location moments, that wouldn't be a drastic loss for the software, so Uber can afford to lose some data in this case;;
- **[Ack 1, Leader]** → Acknowledge 1, The moment the leader saves the message it will return to the user saying that the message was stored;
    - The speed is a little bit slower
    - Potencial Problem: the Broker A saved the message and then returned to the users saying that the message was stored but in the same moment the node goes down, and the Broker A didn’t have time to replicate the data to the followers;
- **[Ack -1, All]** → Acknowledge -1, The producer will send the message to the leader, the leader will replicate to the followers, the followers will notify the leader saying the message was stored and then the leader will respond the client saying the message was safely saved
    - If you can’t afford lose a message no matter what, you should use this type
    - If Broker A goes down doesn’t matter because the message is stored in other brokers;
    - We’ll lost speed to process the messages


### **Producer Usecase: Idempotent**

Suppose you have an application that sends customer orders to a Kafka topic. Each order message has a unique identifier. The consumer application that reads the order messages from the topic processes each order exactly once.

Now, suppose the producer application encounters a network error while sending an order message to Kafka. As a result, it retries sending the message, and the message is delivered twice to the Kafka topic. The consumer application will then process the same order twice, resulting in inconsistencies in the order processing.

However, if the producer application is configured to use the producer idempotent feature, it will ensure that only one copy of the message is delivered to the Kafka topic, even if multiple retries are attempted. This ensures that the consumer application processes each order exactly once, regardless of any duplicate messages in the Kafka topic.

![Producer Idempotent](/images/producer-indepotence.png)

The message 4 first got an error but after the retry rule it tried again and was successfully stored, but on the first error the producer tried to send the message again and in this case we will have a duplicated data.

Kafka has a way to verify when this happens and if we activate this solution it will cause more slowdown in the system, but is a way to avoid duplicated message and order the messages.

The producer idempotent feature ensures that even if a producer sends duplicate messages due to network errors or other issues, Kafka will only store and deliver each message once. This helps prevent data duplication and inconsistencies in the event stream.

While the producer idempotent feature in Kafka can be very useful in preventing data duplication and ensuring exactly-once message delivery, there are some potential downsides to consider:

1. **Increased latency**: The producer idempotent feature requires additional network round trips between the producer and the Kafka broker to ensure that each message is delivered exactly once. This can increase the overall latency of message production.

2. **Higher resource utilization**: This feature requires additional memory and CPU resources on both the producer and the broker side to maintain and track the message state.

## Consumer

Responsible for reading the messages that the producer puts on a topic.

### **Consumers Groups**

The primary role of a Kafka consumer is to read data from an appropriate Kafka broker. A consumer group is a group of consumers that share the same group id. When a topic is consumed by consumers in the same group, every record will be delivered to only one consumer.

> If all the consumer instances have the same consumer group, then the records will effectively be load-balanced over the consumer instances

This way you can ensure parallel processing of records from a topic and be sure that your consumers won’t be stepping on each other toes.

First scenario:

One consumer read all partitions
```
[Producer] ---> [    Topic    ]
				[ Partition 0 ]  ---> [Consumer A]
				[ Partition 1 ]  ---> [Consumer A]
				[ Partition 2 ]  ---> [Consumer A]
```

Second scenario: Consumer Groups

When these consumers are inside a group
```
[Producer] ---> [   Topic     ]       [    Group X   ]
				[ Partition 0 ]  ---> [  Consumer A  ]
				[ Partition 1 ]  ---> [  Consumer A  ]
				[ Partition 2 ]  ---> [  Consumer B  ]
```
Consumer A and B can be the same software but running on different machines and because they are the same software and process the same transactions we can put them on a group and the data will be distributed across this group.
The Partition 0 and 1 will be read by consumer A and the partition 2 by consumer B.

best scenario: 3 partition, 3 consumers
```
[Producer] ---> [   Topic     ]       [    Group X   ]
				[ Partition 0 ]  ---> [  Consumer A  ]
				[ Partition 1 ]  ---> [  Consumer B  ]
				[ Partition 2 ]  ---> [  Consumer C  ]
```

usecase:
```
[Producer] ---> [   Topic     ]       [    Group X   ]
				[ Partition 0 ]  ---> [  Consumer A  ]
				[ Partition 1 ]  ---> [  Consumer B  ]
				[ Partition 2 ]  ---> [  Consumer C  ]
									  [  Consumer D  ]
```
in this case, Consumer D will be AFK because consumers inside a group 
cannot read the same data from another consumer.

If the consumer doesn’t have a group the consumer itself will be a standalone group and would read all the partitions.