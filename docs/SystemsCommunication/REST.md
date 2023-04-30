# **REST**

If you are building REST APIs or REST Services you're using HTTP.
Technically, REST services can be provided over any application layer protocol as long as they conform to certain properties. In practice, basically, everyone uses HTTP Protocol.

Advantages:

- **Simplicity**
- **Stateless →** The server doesn't maintain any information about the client. Each request contains all the information necessary for the server to process it. Each request is a new request, which is why we need to pass headers all the time (JWT Token, etc.).
- **Cacheable**

## REST vs RESTful

A **REST API** (also known as RESTful API) **is an application programming interface** (API or web API) **that conforms to the constraints of REST architectural style and allows for interaction with RESTful web services.**

An **API is a set of rules that define how applications can connect to and communicate with each other**. A REST API is an API that conforms to the design principles of the REST. For this reason, REST APIs are sometimes referred to RESTful APIs.

The only requirement for an API implement REST is that they align to the following six REST design principles - also known as architectural constraints:

1. **Uniform interface**. It indicates that the server transfers information in a standard format. All API requests for the same resource should look the same, no matter where the request comes from. The REST API should ensure that the same piece of data, such as the name or email address of a user, belongs to only one uniform resource identifier (URI). Resources shouldn’t be too large but should contain every piece of information that the client might need.
Uniform interface imposes four architectural constraints:
	- Requests should identify resources. They do so by using a uniform resource identifier.
	- Clients have enough information in the resource representation to modify or delete the resource if they want to. The server meets this condition by sending metadata that describes the resource further.
	- Clients receive information about how to process the representation further. The server achieves this by sending self-descriptive messages that contain metadata about how the client can best use them.
	- Clients receive information about all other related resources they need to complete a task. The server achieves this by sending hyperlinks in the representation so that clients can dynamically discover more resources.


2. **Client-server decoupling**. In REST API design, client and server applications must be completely independent of each other. The only information the client application should know is the URI of the requested resource; it can't interact with the server application in any other ways. Similarly, a server application shouldn't modify the client application other than passing it to the requested data via HTTP.

3. **Statelessness**. statelessness refers to a communication method in which the server completes every client request independently of all previous requests. Clients can request resources in any order, and every request is stateless or isolated from other requests. This REST API design constraint implies that the server can completely understand and fulfill the request every time. REST APIs are stateless, meaning that each request needs to include all the information necessary for processing it. In other words, REST APIs do not require any server-side sessions. Server applications aren’t allowed to store any data related to a client request. No client information is stored between get requests and each request is separate and unconnected.

4. **Cacheability**. When possible, resources should be cacheable on the client or server side. Server responses also need to contain information about whether caching is allowed for the delivered resource. The goal is to improve performance on the client side, while increasing scalability on the server side.

5. **Layered system architecture**. In REST APIs, the calls and responses go through different layers. As a rule of thumb, don’t assume that the client and server applications connect directly to each other. There may be a number of different intermediaries in the communication loop. REST APIs need to be designed so that neither the client nor the server can tell whether it communicates with the end application or an intermediary. In a layered system architecture, the client can connect to other authorized intermediaries between the client and server, and it will still receive responses from the server. Servers can also pass on requests to other servers. You can design your RESTful web service to run on several servers with multiple layers such as security, application, and business logic, working together to fulfill client requests. These layers remain invisible to the client.

6. **Code on demand (optional)**. REST APIs usually send static resources, but in certain cases, responses can also contain executable code (such as Java applets). In these cases, the code should only run on-demand. In REST architectural style, servers can temporarily extend or customize client functionality by transferring software programming code to the client. For example, when you fill a registration form on any website, your browser immediately highlights any mistakes you make, such as incorrect phone numbers. It can do this because of the code sent by the server.

## **Maturity levels**

**Level 0:** The Swamp of POX

Performing an operation on the server without any standardization.

The Swamp of POX (Plain Old XML) means that you’re using HTTP. Technically, REST services can be provided over any application layer protocol as long as they conform to certain properties. In practice, basically, everyone uses HTTP.

Level zero of maturity does not make use of any of URI, HTTP Methods, and HATEOAS capabilities.


**Level 1:** Use of resources

REST’s ‘resources’ are the core pieces of data that your application acts on. These will often correspond to the Models in your application

API design at Level 1 is all about using different URLs to interact with the different resources in your application.

| URL | Operation |
| --- | --- |
| /products/1 | Retrieve |
| /products | Insert |
| /products/1 | Update |
| /products/1 | Remove |


**Level 2:** HTTP Verbs

If we want to get a list of Pages, we make a GET request to `/page`, but if we want to create a new Page, we use POST rather than GET to the same resource - `/page`.

| Verb | Scope | Semantics
| --- | --- | --- |
|GET	|collection|	Retrieve all resources in a collection
|GET	|resource|	Retrieve a single resource
|HEAD	|collection|	Retrieve all resources in a collection (header only)
|HEAD	|resource|	Retrieve a single resource (header only)
|POST	|collection|	Create a new resource in a collection
|PUT	|resource|	Update a resource
|PATCH	|resource|	Update a resource
|DELETE	|resource|	Delete a resource
| OPTIONS|	any|	Return available HTTP methods and other options

The use of HTTP verbs like GET, POST, PUT, and DELETE is another important principle of REST. These verbs are used to describe the operation being performed on a resource. For example, GET is used to retrieve information, POST is used to create a new resource, PUT is used to update an existing resource, and DELETE is used to remove a resource.

**Level 3:** HATEOAS: Hypermedia as the Engine of Application State

Responds to the endpoint by returning what else can be done based on what was just done.

```json
{
	"account": {
		"account_number": 123,
		"balance" : {
			"currency": "usd",
			"value": 100.00
		},
		"links": {
			"deposit": "/accounts/123/deposit",
			"withdraw": "/accounts/123/withdraw",
			"transfer": "/accounts/123/transfer",
			"close": "/accounts/123/close"
		}	
	}
		
}
```

HATEOAS is an advanced concept in REST that allows a server to provide information to the client about what actions can be performed next. This allows for a more dynamic and flexible API design.

