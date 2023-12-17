# Systems Communication

Communication between different components or systems is often necessary. Synchronous communication is a type of communication in which a request is sent and the system waits for a response before continuing. This type of communication is used when the system requires an immediate response to continue its processing.

On the other hand, asynchronous communication is a type of communication in which a request is sent and the system doesn't require an immediate response. The system can continue its processing without waiting for a response. The response will be processed later when it's available.

**Synchronous communication ⇒** sends a request and waits for a response. Examples: phone call, question and answer.

**Asynchronous communication ⇒** sends a request and doesn't require an immediate response. Examples: postal service, sends a letter and doesn't expect a response at that moment.

In software development, when building a web application, synchronous communication is used between the client and the server. When a user submits a request, the server processes the request and sends back a response immediately. However, asynchronous communication is used when performing background tasks such as sending an email or processing a large file. The user doesn't need to wait for the task to complete before continuing to use the application.

## Some Types of System Communication

- [REST](REST.md)
- [gRPC](gRPC.md)
- [GraphQL](GraphQL.md)
