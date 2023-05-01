# **Object-Oriented Programming vs Functional Programming**

**Functional Programming** or **Object Oriented Programming** its more of a personal preference than being a question of which is better than the other.

## **Functional Programming**

**Functional programming** is the form of programming that **attempts to avoid changing state and mutable data**. In a functional program, **the output of a function should always be the same, given the same exact inputs to the function**.

ex:

It will always be the same result, and has no side effects 

```jsx
function sum(a, b) {
	return a + b
}
```

This is because the outputs of a function in functional programming purely rely on the function's arguments, and there is no magic behind the scenes. This is called eliminating side effects in your code.

## **OOP (Object Oriented Programming)**

Object-oriented programming is a programming paradigm in which you program ***uses objects to represent things*** you are programming about (sometimes real-world things). These objects could be data structures. The ***objects hold data about them in attributes***. The attributes in the objects are manipulated through methods or functions that are given to the object.

***For instance***, we might have a ***Person object*** that represents all of the data a person would have: weight, height, skin color, hair color, hair length, and so on. Those would be the attributes. Then the person object would also have *things that it can do* such as: pick a box up, put box down, eat, sleep, etc. These would be the functions that play with the data the object stores.

**The main deal with OOP is the ability to encapsulate data from outsiders.** Encapsulation is the ability to hide variables within the class from outside access — which makes it great for security reasons, along with leaky, unwanted, or accidental usage.

> Object-Oriented Programming is a diverse programming language that provides a clear structure for a program, making it easier to maintain, manage, debug, and reuse the code. This is perhaps the most significant reason why this programming method is so popular.
> 

## Major Concepts of Object-Oriented Programming

### **Encapsulation**

Encapsulation, in general, is nothing but a fancy word for **packaging or enclosing things of interest into one entity.** By definition, **encapsulation describes the idea of bundling data and methods that work on that data within one unit.**

Many programming languages use ***encapsulation*** frequently in the form of ***classes***. A ***class*** is a program-code-template that allows developers to create an object that has both variables (data) and behaviors (functions or methods). A class is an example of encapsulation in computer science in that it consists of data and methods that have been bundled into a single unit.

Encapsulation may also refer to a mechanism of restricting the direct access to some components of an object, such that users cannot access state values for all of the variables of a particular object. Encapsulation can be used to hide both data members and data functions or methods associated with an instantiated class or object.

Encapsulation in programming has a few key benefits. These include:

- **Hiding Data:** Users will have no idea how classes are being implemented or stored. All that users will know is that values are being passed and initialized.
- **More Flexibility:** Enables you to set variables as red or write-only. Examples include: setName(), setAge() or to set variables as write-only then you only need to omit the get methods like getName(), getAge() etc.
- **Easy to Reuse:** With encapsulation it's easy to change and adapt to new requirements.

### **Abstraction**

Abstraction in Object Oriented Programming solves the issues at the design level.

**Displays essential information and hides unwanted information**, such as the inner details of how objects are implemented, from the user. Abstraction is vital to reduce programming complexity as it allows programmers to display only the relevant information of the object to the user.

That enables the user to implement more complex logic on top of the provided abstraction without understanding or even thinking about all the hidden complexity.

ex:

```jsx
class Employee{
    private name;
    private baseSalary;
   
    setName(val){
        this.#name = val;
    }
    setBaseSalary(val){
        this.#baseSalary = val;
    }
    
    getName(){
        return this.#name;
    }
    
    getSalary(){
        let bonus = 1000;
        return this.#baseSalary + bonus;
    }
}
var emp = new Employee();
emp.setName("abc");
emp.setBaseSalary(100);
console.log(emp.getName());
console.log(emp.getSalary());
```

### **Inheritance**

It is a mechanism where you can to **derive a class from another class for a hierarchy of classes that share a set of attributes and methods.**

This concept lets programmers create new objects with the same attributes as old or existing objects. In essence, we are inheriting the attributes of parent objects to child objects.

ex:

```jsx
class Fruit {
	name
	color
	constructor(name, color) {
		this.name = name
		this.color = color
	}
}

// Strawberry is inherited from Fruit
class Strawberry extends Fruit {
	constructor(name, color) {
		super(name, color)
	}
}
```

### **Polymorphism**

Allows programmers to run a child object exactly like the parent whilst retaining their specific methods.

Let’s take a new example to understand this concept further. Say we have an object called “Vehicle”, and we create new child objects, called “Car,” “Bus,” and “Train.”

Consider that the vehicle object has a method called “run.”

Now according to the principles of Polymorphism, this method can be passed on to the child objects as well, **but the way each child object implements this method will be different and specific to them.**

**Polymorphism is the practice to design objects in such a way that they share and override behavior from parent objects.**

## Data Type vs Data Structure

A **Data type** is one of the forms of a variable to which the value can be assigned of a given type only. This value can be used throughout the program.

A *data type* is the most basic and the most common classification of data. It is this through which the compiler gets to know the form or the type of information that will be used throughout the code. So basically data type is a type of information transmitted between the programmer and the compiler where the programmer informs the compiler about what type of data is to be stored and also tells how much space it requires in the memory. Some basic examples are int, string etc. It is the type of any variable used in the code.

ex:

```jsx
int a = 5;
float b = 5.0;
char c = 'A';
```

the variable ‘a’ is of data type integer which is denoted by int a. So the variable ‘a’ will be used as an integer type variable throughout the process of the code. And, in the same way, the variables ‘b’ and ‘c’ are of type float and character respectively. And all these are kinds of data types.

A ***data structure*** is a collection of different forms and different types of data that has a set of specific operations that can be performed. It is a collection of data types. It is a way of organizing the items in terms of memory, and also the way of accessing each item through some defined logic. Some examples of data structure are arrays, lists, stacks, queues, linked lists, binary tree and many more.

It’s like a container!

For example, you have to store data for many employees where each employee has his name, employee id and a mobile number. So this kind of data requires complex data management, which means it requires data structure comprised of multiple primitive data types. So data structures are one of the most important aspects when implementing coding concepts in real-world applications.

Data Structure is the collection of different kinds of data. That entire data can be represented using an object and can be used throughout the entire program.
