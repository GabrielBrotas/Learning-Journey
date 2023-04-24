**Producer Usecase: Indepotente**

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/cdd70d2e-7d23-4a08-aa0f-83195f00873c/Untitled.png)

The message 4 first got an error but after the retry rule it tried again and was successfully stored, but on the first error the producer tried to send the message again and in this case we will have a duplicated data.

Kafka has a way to see when this happen and if we activate this solution it will cause more slowdown in the system but is a way to avoid duplicated message and order the messages.

**Consumers Groups:** 

```jsx
First case: One consumer read all partitions;
[Producer] ---> [   Topic     ]
								[ Partition 0 ]  ---> [Consumer A]
								[ Partition 1 ]  ---> [Consumer A]
								[ Partition 2 ]  ---> [Consumer A]

Second case: Consumer Groups
When these consumers are inside a group

[Producer] ---> [   Topic     ]       [    Group X   ]
								[ Partition 0 ]  ---> [  Consumer A  ]
								[ Partition 1 ]  ---> [  Consumer A  ]
								[ Partition 2 ]  ---> [  Consumer B  ]

best scenario: 3 partition, 3 consumers
[Producer] ---> [   Topic     ]       [    Group X   ]
								[ Partition 0 ]  ---> [  Consumer A  ]
								[ Partition 1 ]  ---> [  Consumer B  ]
								[ Partition 2 ]  ---> [  Consumer C  ]

usecase:
[Producer] ---> [   Topic     ]       [    Group X   ]
								[ Partition 0 ]  ---> [  Consumer A  ]
								[ Partition 1 ]  ---> [  Consumer B  ]
								[ Partition 2 ]  ---> [  Consumer C  ]
																			[  Consumer D  ]
in this case Consumer D will be AFK because consumers inside a group 
cannot read the same data from another consumer.
```

Consumer A and B can be the same software but running on different machines and because they are the same software and process the same transactions we can put them on a group and the data will be distributed across this group.
The Partition 0 and 1 will be read by consumer A and the partition 2 by consumer B.

Kafka will distribute this data;

If the consumer doesn’t have a group the consumer itself will be a standalone group and would read all the partitions.