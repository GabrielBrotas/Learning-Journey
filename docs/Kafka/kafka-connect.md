Open source platform that works as a data hub to create simple centralizations such as database, key-value stores, search indexes and file systems.

Kafka Connect is a framework for connecting Kafka with external systems, including databases.

A Kafka Connect cluster is a separate cluster from the Kafka cluster. The Kafka Connect cluster supports running and scaling out connectors (components that support reading and/or writing between external systems).

The Kafka connector is designed to run in a Kafka Connect cluster to read data from Kafka topics and write the data into Snowflake tables.

**How it works?**

Lets suppose I have my data stored on an CRM such as Salesforce and I want to store that data on another system or a database (Postgres, MySQL,…)

I can connect my Kafka Connect on Salesforce, the salesforce data will be stored on a Kafka topic and from this topic I can save on my database;

Or if I want to put my SQL data on Mongo,

it requires some effort to create this integration and Kafka Connect help us with this problem without us need to write a line of code

```jsx
[Apache Kafka] <----> [Kafka Connect]
  					 MySql <--- [Connector]
    			 MongoDb <---	[Connector]
  											[Connector] ---> Lambda
											  [Connector] ---> Elasticsearch
```

A connector can be a mysql, mongo, lambda, elastic search, salesforce,…

Connectors Type:

- Data Sources ⇒ Get data from somewhere to send to Apache Kafka, Ex:
    - MySQL
    - Mongo
    - SalesForce
- Sinks ⇒ Where to send this information
    - Elasticsearch
    - AWS Lamda

Ex: I can send this MySQL data and send to a AWS Lambda,
Get data from MongoDB and send to a ElasticSearch,…

[https://www.confluent.io/hub/](https://www.confluent.io/hub/)

### Converters

The tasks use “converters” to change the data format for read or write purpose;

Popular formats

- Avro; better undersantd of json files
- Protobuf;
- JsonSchema;
- Json;
- String;
- ByteArray;

### DLQ - Dead Letter Queue

When there is a invalid registry, for any reason, this error can be handled on the connector config through the property “errors.tolerance”. This type of config just can be used by “Sink” connectors;

- none: the task stops immediately
- all: errors are ignored and the process continue normally
- errors.deadletterqueue.topic.name = <topic name>