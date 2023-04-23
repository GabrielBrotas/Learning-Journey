# gRPC
gRPC is a high-performance framework developed by Google that facilitates communication between systems in an extremely fast and lightweight way, independent of language. gRPC utilizes Remote Procedure Call (RPC) to allow the client to call a function on the server, enabling developers to build scalable and distributed systems with ease.

One of the main benefits of gRPC is its speed. By utilizing Protocol Buffers, a mechanism created and used by Google to serialize structured data, gRPC can send and receive data faster than traditional text-based formats like JSON. Additionally, gRPC supports bidirectional streaming using HTTP/2, which allows data to be sent in binary format and compressed, reducing network resource consumption and latency.

gRPC is ideal for microservices architectures and can be used in a variety of environments, including mobile, browsers, and backend applications. It also offers automatic library generation, which can significantly reduce development time.

**In which cases can we use it?**

- Ideal for microservices;
- Mobile, Browsers, and Backend;
- Automatic library generation;
- Bidirectional streaming using HTTP/2 (Faster than HTTP 1, allows sending data in binary format, data streaming, etc.)

Languages with official support:

- gRPC-GO
- gRPC-JAVA
- gRPC-C
    - C++
    - Python
    - Ruby
    - Objective C
    - PHP
    - C#
    - Node.js
    - Dart
    - Kotlin / JVM

RPC ⇒ Remote Procedure Call

The client calls the function on the server

```
    Client                          Server
server.soma(a,b)                 func soma(int a, int b) {}
```

**Protocol Buffers ⇒** is a mechanism created and used by Google to serialize structured data. It defines how you want the data to be structured - in a file with the extension **`.proto`**.

```
syntax = "proto3"

message SearchRequest {
	string query = 1;
	int32 page_number = 2;
	int32 result_per_page = 3;
}
```

**Protocol Buffers vs JSON**
While JSON is a popular format for transmitting data, it has some drawbacks in terms of performance and network resource consumption. Protocol Buffers, on the other hand, offer several advantages over JSON:

- Binary files < JSON, JSON is heavier because it is plain text;
- Lightweight: The process of serialization and deserialization with Protocol Buffers is more lightweight than with JSON, requiring less CPU resources.
- Network resource consumption: Protocol Buffers consume less network resources than JSON.
- Process is faster;

**HTTP/2**

- Launched in 2015;
- The transmitted data is binary and not text like in HTTP 1.1;
- Uses the same TCP connection to send and receive data from the client and server (Multiplex);
- Server push;
- Headers are compressed;
- Uses fewer network resources;
- Process is faster.

**REST vs gRPC**

| REST | gRPC
| --- | --- |
| Text / JSON | Protocol Buffers
| Unidirecional | Bidirecional e Asynchronous
| High Latency | Low Latency
| No contract (higher chance of errors) | Defined contract (.proto)
| No streaming support (Request / Response) | Streaming support