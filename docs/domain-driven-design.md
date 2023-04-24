# Domain Driven Design

Defines how to model software in general.

It is a way of developing software with a focus on the heart of the application - what we call the domain - with the objective of understanding its rules, processes and complexities, thus separating them from other complex points that are normally added during the development process.

DDD is about modeling ubiquitous (universal) language within a bounded context.

## **Complex software**

- DDD is / should be applied for cases of complex software projects;
- Large projects have many areas, many business rules, many people with different views in different contexts;
- There is no way not to use advanced techniques in highly complex projects;
- Much of the complexity of this type of software does not come from technology, but from communication, context separation, understanding the business from different angles;
- People (Product Manager, Owner, Developer, Experts, Architects, ...)

DDD should be applied to large projects, which have several areas, several business areas, and people who are in different contexts.

DDD was created to provide more clarity in the project, to understand that the software is not just another one. Our role as a developer is to understand this and know how to model for each type of system and context.

Domain-Driven Design is, above all, **communication**. In DDD modeling and implementation go hand in hand.

Domain experts (users, analysts and other experts in the field), along with developers and architects work hand in hand with a common goal: **build domain-driven software to meet customer needs.**

To do this, in the first place, **it is necessary that everyone use a common language** and that there is no translation in the communication between team members.

## **How can DDD help?**

- **Understand in depth the domain (domain) and subdomains of the application.**
**Domain** is something that is connected with the main function of the application that we are going to develop, it is the heart of the software that we are going to develop;
**Subdomain** is the separation of the domain into pieces, which make the pieces fit together to create the core of the application. It is important to understand the limit of each subdomain.

- **Have a universal language (ubiquitous language) among all involved.**
Use jargon from the area that is used in that context.

    Ex: the customer of a B2B company are companies, but the customer of a bakery is people, so the entity 'customer' will not always be the same thing, it all depends on the context.

    If the company calls invoice ABC, in our application we should also call it that because it will facilitate communication between Solution Architect - Company, keeping everyone in the same context

- **Create the strategic design using Bounded Contexts.**
Understand the context / boundaries of each subdomain

- **Create the tactical design to be able to map and aggregate the application's entities and value objects, as well as domain events.**

- **Clarity of what is business complexity and technical complexity.**

## **Domain vs Subdomain**

Domain is the problem as a whole, when we explore this domain/problem further, we begin to identify some points that can be treated in isolation, and each point has a degree of importance within the main domain.

**Example:** Within Netflix, the main core (core domain) is the streaming service, listing the catalog and playing the movies, if you don't have this, it makes no sense for the application to exist

**Core Domain:**

- Heart of the business;
- Competitive advantage of the company;

**Support subdomain:**

- Support the Domain on a day-to-day basis;
    
    For example: within an ecommerce, the products and checkout are the core domain, but a warehouse (distribution center) is needed, which works as the support subdomain
    
- Makes domain operation possible;

**Generic subdomain**

- Supports the subdomain and core domain but does not generate a competitive advantage for the company;
- Are easily replaceable;
- Auxiliary software;

## **Problem Space vs Solution Space**

DDD → Understand the problem and how you model the problem so you can solve it.

With that, we end up having a problem space and a solution space

```json
Problem                             Solution
-----------------------      ------------------------------
(1) Domain overview      =>   (3) Analysis and modeling of the 
								  domain and its complexities.

        ⬇️                             ⬇️
        ⬇️                             ⬇️

(2) Subdomains           =>   (4) Delimited contexts
```

When we have an overview of the domain and its complexities, we begin to understand and separate the subdomains, still in the problem space.

Solution ⇒ How can I understand this problem and organize it in a way that I can solve all this, take each subdomain and delimit contexts, each generated context ends up becoming a sub product;

This way we can have the domain modeled and the contexts delimited so that we can understand what we have to do and what is the priority.

Subdomains with delimited contexts ⇒ specific problem we have to solve.

**Bounded Contexts**

When we have a subdomain we can delimit them to create a bounded context.

A bounded context is an explicit division within a domain model. A border/boundary of a domain we are modeling.

One of the ways we manage to bring this delimitation is through **ubiquitous language**, we can understand where we are through the language that is being spoken in that context.

When everyone is speaking the same language we realize that we are in the same context, when that language starts to change we begin to identify that we are going to another context.

**“Context is King”**

The context will always determine in which area of the company we are working, what type of problem we are trying to solve, and also the language can be the same from one place to another but have different meanings.

**Examples:**

- Ticket sales ⇒ Ticket // ticket purchase
- Customer support ⇒ Ticket // support request identifier

When we have two words that are the same but that represent different things, we are in a different context.

If we are in a monolithic system, we will have to create different entities for each one according to its context.

- Finance ⇒ eNFS
- Inventory ⇒ XPTO (name for invoice)

When we have two different words that means the same thing we are probably in a different context.

**Cross elements**

Often, despite being in different contexts, these models end up talking between entities / transversal elements.

Example:

- Ticket sales ⇒ Customer
- Customer support ⇒ Customer

Despite being different context is the same entity, however, despite being the same entity they will have different information.

- Ticket sales ⇒ Customer → Event, Ticket, Location, Seller...
- Customer support ⇒ Customer → Ticket, Question, Department, Responsible,...

For each context, an entity will have to be customized for it, as having a class that wants to handle everything ends up being unfeasible and difficult to maintain

## **Entities**

Entities are unique, they must have unique IDs, each one is different from the other;

Entities carry attributes that can change over time (removing or adding);

**Anemic entities**
```js
class Customer {
	_id: string;
    _name: string;
	_address: string

	constructor(id: string, name: string, address: string) {
        this._id = id;
		this._name = name;
		this._address = address
    }

	get id(): string {
		return this._id
	}

	get name(): string {
		return this._name
	}

	get address(): string {
		return this._address
	}

	set name(name: string) {
		this._name = name
	} 

	set address(address: string) {
		this._address = address
	}
}
```

Anemic entities are the type that only carry data and change the name of properties. And we usually create these entities to be manipulated by the ORM, these are entities that don't have a significant value in themselves.

Rich entities are entities that have unique value, data can be changed, have behavior and carry business rules, and it is in these business rules that the heart of the business lives.

Now, instead of entities just loading data, they will define how the entity should behave (business rules, self-validation, etc...), because if the client says that the XPTO entity now behaves differently, that's it entity that we must change.

The first thing we must do when we think of an Entity is to think about what kind of behavior it will carry.

Ex:

This type of change doesn't have any expressiveness, it's just there for the sake of it, it's a method of changing an attribute
```js
	set name(name: string) {
		this._name = name
	} 
```

After:

It means that this Entity, its business rule, allows a user to change its name,
the entity needs this method
```js
changeName(name: string) {
		this._name = name
	} 
```
Consistency in the first place: an Entity will always have to represent the correct and current state of that element, that is, if in the database the entity has (_id, name, address and status) and all fields are mandatory, ALWAYS ALWAYS all data from that entity must have these attributes, if by any chance a piece of data does not have an address, it means that it is violating the DDD and the rich domain rules.

Whenever we consult this entity, the data has to be consistent, since it is not consistent, we cannot validate business rules. When we talk about DDD we must be able to trust 100% of the time in the current state of the object.

**Principle of self-validation:** An Entity, by default, it must always self-validate

Problem:

If we leave the responsibility to another system resource, the data may be inconsistent.
```js
class Customer {
	_id: string;
    _name: string;
    
	constructor(id: string, name: string) {
        this._id = id;
		this._name = name;
        this.isValid()
	}

	get id(): string {
		return this._id
	}

	get name(): string {
		return this._name
	}

	changeName(name: string) {
		this._name = name
        this.isValid()
	}

    isValid() {
        if(this.name.length < 5) {
            throw ValidationError("name length must the greater than 5.")
        }
    }
}

const newCustomer = new Customer("1", "")
```

Architecture:
```md
src/...
  
    // Business complexity / business rules
	// A single way to run, the way the customer is asking.
	/domain/... 

	// Accidental Complexity / Conversation with the Outside World / Storing Data...
    // n ways to solve, Excel, Sass, DB, Cloud,...
	/infra/... <- 

```

## **Object Values**

“When you only care about the attributes of a model element, classify it as a Value Object”

A Value Object is immutable, it doesn't change it is replaced by another VO.

EX:
```js
class Address {
	_street: string;
	_number: number;
	_zip: string;
	_city: string;

	constructor(street: string, number: number, zip: string, city: string) {
		this._street = street;
		this._number = number;
		this._zip = zip;
		this._city = city
	}
}

class Customer {
	_id: string;
    _name: string;
	_address!: Address;

	constructor(id: string, name: string) {
        this._id = id;
		this._name = name;
    }

	get id(): string {
		return this._id
	}

	get name(): string {
		return this._name
	}

	get address(): Address {
		return this._address
	}

	set name(name: string) {
		this._name = name
	} 

	set address(address: Address) {
		this._address = address
	}
}
```

## **Domain Services**

> ***A domain service is a stateless operation that performs a domain-specific task. Often the best indication that you should create a Service in the domain model is when the operation you need to perform doesn't seem to fit as a method on an Aggregate or a Value Object.***

> ***When a significant process or transformation in the domain is not the natural responsibility of an ENTITY or Value Object, add an operation to the model as a stand-alone interface declared as a SERVICE. Set the interface in based on the domain model language and make sure the operation name is part of the UBIQUITOUS LANGUAGE. Make the SERVICE stateless.***

Domain Service is stateless;

Any alteration / transformation / transaction,..., anything that affects the domain and that we cannot perform in the Entity class itself, because we need access to another Entity, OV, or something external is because we need to use a Domain Service .

These services run on the Domain layer, where the business rules take place.

When to create domain service?

- Can an entity perform an action that will affect all entities?
- How to perform a batch operation?
- How to calculate something whose information is contained in more than one entity?

**Careful:**

- When there are many Domain Services in your project, MAYBE this could indicate that your aggregates are anemic. (only get and set)
- Domain Services are Stateless (do not keep state)

## **Repositories**

> ***A repository commonly refers to a place of storage, generally considered a place of security or preservation of the items stored there. When you store something in a repository and then go back to retrieve it, you expect it to be in the same state it was in when you put it there. At some point, you can choose to remove the stored item from the repository.***

These objects, similar to collections, are about persistence. Every Persistent Aggregate type will have a Repository. Generally speaking, there is a 1-1 relationship between an Aggregate type and a Repository.


## **Domain Events**

> ***Use a domain event to capture an instance of something that happened in the domain.***

> ***The essence of a domain event is that you use it to capture things that might trigger a change in the state of the application you are developing. These event objects are processed to cause system changes and stored to provide an AuditLog.***

Perform an operation based on an event or store a log;

Every event must be represented in an action performed in the past;

Ex:

- UserCreated;
- OrderPlaced;
- EmailSent;

**When to use?**

Normally a Domain Event should be used when we want to notify **other Bounded Contexts** of a state change.

Communication with external contexts;

**Components**

- **Event** → contains the message along with the timestamp of when it occurred;
- **Handler** → concrete implementation of the event that is triggered, performs processing when an event is called, an event can have multiple handlers. ex: send email, call external api, send push notification,...
- **Event Dispatcher** → Responsible for storing and executing the handlers of an event when it is triggered; logs all events and their handlers.

**Flow:**

- Create an “Event Dispatcher”
- Create an “Event”
- Create a “Handler” for the “Event”
- Registers the Event, along with the Handler in the “Event Dispatcher”

Now to trigger an event, just execute the “notify” method of the “Event Dispatcher”. At that moment, all Handlers registered in the event will be executed.

## **Modules**

> ***In a DDD context, Modules in your model serve as named containers for classes of domain objects that are highly cohesive with each other. The goal should be loose coupling between classes that are in different modules. Since the Modules used in DDD are not anemic or generic storage bins, it is also important to properly name the Modules.***

- Represents the application represented by the domain;
- The modules must respect the universal (ubiquitous) language;
- Low coupling;
- One or more aggregates must be together only if they make sense;
- Organized by domain / subdomain and not by type of objects
- They must respect the same division when they are in different layers (infra, domain, ...) it is easier to maintain a correlation;

## **Factories**

> ***Shift the responsibility for creating instances of complex objects and Aggregates to a separate object, which may not have responsibility in the domain model but is still part of the domain design. Provide an interface that encapsulates all complex creation and doesn't require the client to reference the concrete classes of the objects being instantiated. Create entire Aggregates at once, enforcing their invariants.***

Every time we need to create a complex object, we can delegate this to the factory.

```md
Client => (Input, Specifies what it wants) =>
Factory => (Makes object that satisfies client and internal rules) =>
Object => Output
```