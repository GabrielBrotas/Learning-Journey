Topic is a communication channel responsable for receive and make the kafka messages available.

If you want to send a message you have to send a message to a topic, the same thing for reading

```
                    /-- [Consumer]
[Producer] --> Topic <-- [Consumer]
                    \-- [Consumer]
```

Kafka is different from RabbitMQ because the same message can be read for differents consumers;

RabbitMQ save the data in memory while Kafka saves on disk, that way you can read the same message over and over again.

**Partitions - Anatomy of a record**

Record:

```jsx
			  [ Headers   ]
[Offset 0] -> | Key       |
			  | Value     |
			  [ Timestamp ]
```

- Headers → Metadata that can be useful for us;
- Key → To ensure the delivery order;
- Value → Payload, message content;
- Timestamp → Created at;

Each topic can have one or more partitions to ensure distribution and resilience of the data;

You can think of a partition as being a drawer, it’s a space on the disk where Kafka will store the message. 

Ex:

```jsx
		---> [Partition 1] Broker A
Topic X ---> [Partition 2] Broker A or Broken B
		---> [Partition 3] Broker A, B, C or D....
```

You cannot have all the eggs on the same basket;

The idea is to not have all the messages on the same partition/broker, every time we increase the amount of partition the messages will be more distributed/separeted;
If the broker A goes down at least we can have the message on the broker B, C,…

Lets suppose we have 1 million messages and single computer, it will require a lot of computational power from this computer and also a lot of effort to process every message;
So we can create another computer and to ensure we will not have the both computers reading the same data we split these datas on differents partitions, each computer reads the same topic but from different partitions;

Now we have twice more speed/power;

**Partitions and Keys**

How can we guarantee the order of messages?

About the “Keys”

```jsx
[Partition 1] <---- Consumer 1 (slow)
		[Offset 0], [Offset 1]

[Partition 2] <---- Consumer 2 (fast)
		[Offset 0],

[Partition 3] <---- Consumer 3
		[Offset 0],...
```

The only way we can guarantee the order of the messages is when they are on the same partition;

Ex: User A buy a product, then at the same moment he will request a refund, but these messages can be in different partitions, the purchase request can be at partition 1 and the refund at the partition 2, but in this scenario the Consumer 1 is slow, so what if this first message receive an error and consumer 2, which is fast, has already processed the refund transaction?

In order to guarantee the order of the messages to be executed these messages must be at the same partition and we can do it by using key.

Ex:

```jsx
Transfer Message [0] -> Key=Movimentation
Refund Message   [1] -> Key=Movimentation
Random Message   [2] -> No keys
```

In this case the first and the second message will be placed on the same partition and the last will be placed with the kafka default behavior, distributing between partitions;

**Distributed Partitions**

What usually happens:

```jsx
			   ---> [Broker A][Partition 1]
Topic: [Sales] ---> [Broker B][Partition 2]
			   ---> [Broker C][Partition 3]
```

With **Replication Factor**:

```jsx
			   ---> [Broker A][Partition 1][Partition 3]
Topic: [Sales] ---> [Broker B][Partition 2][Partition 1]
		       ---> [Broker C][Partition 3][Partition 2]
```

Replication Factor = 2

Replication factor is a way to guarantee data resilience because if the Broker A goes down we have a copy of the partition 1 and 3 on broker B and C. So the most critical our data is, we can have more replication factor to ensure that we will never lose that data;

The more replication we have more disk space will be required.

The recommendation is to have 2 replication factor and if the application is very critical you can have 3.

**Partition Leadership**

- Leaders = Bold
- Followers = normal

All partitions are on the same topic. ex: Sale

|[Broker A ]|[Broker B ]|[Broker C ]|[Broker D ]|
| --- | --- | --- | --- |
|[**Partition 1**]|[Partition 1]|[Partition 4]|[Partition 3]|
|[Partition 2]|**[Partition 2]**|[Partition 2]|[Partition 2]|
|[Partition 4]|[Partition 3]|[**Partition 3**]|[**Partition 4**]|

The bold paritions are the leaders, when a consumer has to read a data he will always go to the leader to retrieve that information, even if you have 10 copy of this partition the consumer always is going to the leader.

In case a leader partition goes down, the consumer will read from the next available partition, ex:
Broker A goes down and is no longer available, so now Broker B will have Partition 1 and 2 as leader.
The follower is just a backup in case a leader goes down.

**Delivery Guarantee**

```jsx
[Producer] ----> [Broker A][Topic A] Leader
				 [Broker B][Topic A] Follower
				 [Broker C][Topic A] Follwer
```

The Producer will alwasy send the message to the leader broker first.

**Types of delivery**

- [Ack 0, None] → Acknowledge 0, None, AKA FF (Fire and Forget)
    - It’s the fastest way to send messages because Kafka doesn’t waste time responding to the user so it can handle way more transactions
    - Uber usecase: The driver send his location every 10 seconds, this location is sent to Kafka to handle that message, if Kafka loses 2 location moments, that wouldn't be a drastic loss for the software, so Uber can afford to lose some data in this case;;
- [Ack 1, Leader] → Acknowledge 1, The moment the leader saves the message it will return to the user saying that the message was stored;
    - The speed is a little bit slower
    - Potencial Problem: the Broker A saved the message and then returned to the users saying that the message was stored but in the same moment the node goes down, and the Broker A didn’t have time to replicate the data to the followers;
- [Ack -1, All] → Acknowledge -1, The producer will send the message to the leader, the leader will replicate to the followers, the followers will notify the leader saying the message was stored and then the leader will respond the client saying the message was safely saved
    - If you can’t afford lose a message no matter what, you should use this type
    - If Broker A goes down doesn’t matter because the message is stored in other brokers;
    - We’ll lost speed to process the messages
