# Open-closed Principle

*Software components should be closed for modification, but open for extension.*

that is, when new behaviors and features need to be added to the software, we should extend and not change the original source code.

Example:
```js
class InsuranceCompany {
    discountRate(customer VehicleInsuranceCustomer) {
        if(customer.isLoyalCustomer()) {
            return 20;
        }
        return 10;
    }
}

class VehicleInsuranceCustomer {
    public boolean isLoyalCustomer() {
        return true; 
    }
}
```

`InsuranceCompany` has the `discountRate()` method. But as you can see, the parameter of this method only accepts the `VehichleInsuranceCustomer` type. But what if we want to introduce another type of customer? we would have to add another method.

Ex:
```js
class InsuranceCompany {
    
    discountRate(customer VehicleInsuranceCustomer) {
        if(customer.isLoyalCustomer()) {
            return 20; 
        }        
        return 10;
    }

    discountRate(customer HomeInsuranceCustomer) {
        if(customer.isLoyalCustomer()) {
            return 20; 
        }        
        return 10;
    }

    discountRate(customer LifeInsuranceCustomer) {
      if(customer.isLoyalCustomer()) {
          return 20; 
      }        
        return 10;
    }

}

class VehicleInsuranceCustomer {
    isLoyalCustomer() {
        return true; 
    }
}

class HomeInsuranceCustomer {
    isLoyalCustomer() {
        return true; 
    }
}

class LifeInsuranceCustomer {
    isLoyalCustomer() {
        return true; 
    }
}
```

This is the problem. You have to keep introducing duplicate code because the method is not “open for extension”, it does not allow dynamic input. This makes the code difficult to maintain and fix.

**Solution:** Work with abstractions
```js
class InsuranceCompany {
    // Parameter is now abstracted 
    discountRate(customer CustomerProfile) {
        if(customer.isLoyalCustomer()) {
            return 20; 
        }        
        return 10;
    }

}

// Core 
interface CustomerProfile {
    isLoyalCustomer(): boolean;
}

class VehicleInsuranceCustomer implements CustomerProfile {
    isLoyalCustomer() {
        return true; 
    }
}

class HomeInsuranceCustomer implements CustomerProfile {
    isLoyalCustomer() {
        return true; 
    }
}

class LifeInsuranceCustomer implements CustomerProfile {
    isLoyalCustomer() {
        return true; 
    }
}
```

Classes that need to communicate with InsuranceCompany must implement an interface, so we're making an abstraction. By doing this we can add more customers **(open for extension)**, and also we are not obliged to modify the InsuranceCompany code (closed for modification).

Benefits:

- Easy to add new features;
- Less development and testing cost.
- Open Closed Principle requires decoupling, which ends up following the Single Responsibility Principle.