# **REST**

If you are building REST APIs or REST Services you're using HTTP.
Technically, REST services can be provided over any application layer protocol as long as they conform to certain properties. In practice, basically, everyone uses HTTP Protocol.

- **Simplicity**
- **Stateless →** The server doesn't maintain any information about the client. Each request contains all the information necessary for the server to process it. Each request is a new request, which is why we need to pass headers all the time (JWT Token, etc.).
- **Cacheable**

**Maturity levels**

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