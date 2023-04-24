# Dependency Inversion Principle

Dependency Inversion Principle corresponds to **D** among SOLI**’D’** Principles. Its principle starts with this statement.

> High-level modules should not depend on low-level modules. Both should depend on abstractions.

**What is Abstraction?**

Code without abstraction:
```js
class Benz  {
    drive() {
    }

}

class CarUtil {
    drive(benz Benz) {
        benz.drive();
    }
}
```

When you change `drive()` method inside `Benz` class, `CarUtil` is directly affected. This is prone to make bugs.

> Tight Coupling is the most undesirable feature in Software

```js
interface Car {
    drive();
}

class Benz implements Car {
    @Override
    drive() {
    }

}

class Tesla implements Car {
    @Override
    drive() {
    }

}

class CarUtil {
    drive(car Car) {
        car.drive();
    }
}
```

***“Abstractions should not depend on details. Details should depend on abstractions.”***

```java
import java.util.Arrays;
import java.util.List;

// High Level Module 
class ProductCatalog {

    public void listAllProducts() {

        // High Level Module depends on Abstraction 
        ProductRepository productRepository =  new SQLProductRepository();

        List<String> allProductNames = productRepository.getAllProductNames();

        // Display product names
    }

}

interface ProductRepository {
    List<String> getAllProductNames();

}

// Low Level Module
class SQLProductRepository implements ProductRepository {

    public List<String> getAllProductNames() {
        return Arrays.asList("soap", "toothpaste", "shampoo");
    }

}
```

**Why doing this?**

**First,** you don’t know what database you are going to use. It may not be specifically `SQL`.

**Second,** `ProductCatalog`‘s `listAllProducts()` does not depend on a specific object. This means, when you change code in `SQLProductRepository`, `ProductCatalog` is not directly affected. You just have achieved `loose-coupling`.
