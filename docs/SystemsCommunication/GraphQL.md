# GraphQL

Query language for APIs that allows you to request and receive only the data you need, in a single request, reducing the number of API requests required. It was developed by Facebook in 2012 and was publicly released in 2015.

- **Hierarchical:** Queries are hierarchical, meaning that the shape of the query matches the shape of the data returned, allowing for more efficient and flexible data retrieval.
- **Strongly Typed:** Provides a type system that allows you to specify the structure of your data and catch errors before they happen.
- **Client-Specified Queries:** The client specifies the data it needs, allowing for more efficient API requests and reduced bandwidth usage.
- **Schema-Driven:** The schema is the contract between the server and the client, defining the data types, fields, and operations that can be performed.

"Queries" perform queries and retrieve data according to the request. They are executed in parallel.

"Mutation" performs the process of create, update, and delete. It is executed serially.


**In which cases can we use it?**

- When you need flexible and efficient API for querying data.
- When you have complex or nested data structures.
- When you want to reduce the number of API requests required.

| GraphQL | REST |
| --- | --- |
| Allow to retrieve data from multiple resources in a single request. | Clients must make separate requests for each resource they need. |
| Clients retrieve only the data they need. | Clients receive all the data associated with a resource, whether or not they need it. |
| Provides documentation and validation for clients. | Does not have a standardized schema, which can make it difficult for clients to understand the structure and relationships of resources. |
