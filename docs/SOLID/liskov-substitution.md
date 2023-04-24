# Liskov Substitution Principle

> Objects should be replaceable with their subtypes without affecting the correctness of the program

Subclasses can be substituted for their parent classes.

Class Y extending class X, class X must be replaceable by class Y.

Example of the duck, a real duck and a rubber duck, the battery duck does the same thing as the real duck, however, it uses batteries, so it is violating this principle because it is not a real duck.

> If S is a subtype of T, then objects of type T, in a program, can be replaced by objects of type S without changing the program's properties.

Wrong:
```js
class Car {
    double getCabinWidth() {
    // return cabin width 
    }	
}

class RacingCar extends Car {

    public double getCabinWidth() {
        // ...
    }
    
    public double getCockpitWidth() {
        // return cockpit width 
    }
}
```

the Car interface cannot be replaced by RacingCar so it is hurting this principle.
