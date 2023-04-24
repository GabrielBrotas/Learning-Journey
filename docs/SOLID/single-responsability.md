# Single Responsibility Principle

A class should have one, and only one, reason to change.

This principle states that a class must be specialized in a single subject and have only one responsibility within the software, that is, the class must have a single task or action to perform.

A class should have only one responsibility, it cannot do more than it was created to do.

- "**Every Software Component should have only one responsibility.**"

A software component can be understood as a class, function, method, or even a module.

It's very common when we are developing a software to give a class more than one responsibility and end up creating classes that do it all — God Class*. At first, this may seem efficient, but as the responsibilities end up getting mixed up, when there is a need to make changes to this class, it will be difficult to modify one of these responsibilities without compromising the others. Every change ends up being introduced with a certain level of uncertainty in our system — especially if there are no automated tests!

*God Class: In object-oriented programming, a class that knows too much or does too much.

Bad code:
```js
/** Before Refactoring **/  
// Too Many Responsibilities 
// - Measurements of squares 
// - Rendering images of squares 
class Square {

    int side = 5;

    public int calculateArea() {
        return side * side;
    }

    public int calculatePerimeter() {
        return side * 4; 
    }

    public void draw() {
        if (highResolutionMonitor) {
            // Render a high resolution image of a square
        } else {
            // Render a normal image of a square
        }
    }

    public void rotate(int degree) {
        // Rotate the image of the square clockwise to
        // the required degree and re-render 
    }

}
```

The Square class has two responsibilities, measuring the area of the square and rendering the image to the screen.

Refactoring:
```js
/** After Refactoring **/  
// Responsibility: Measurements of squares 
// After Refactoring
class Square {

    int side = 5;

    public int calculateArea() {
        return side * side; 
    }

    public int calculatePerimeter() {
        return side * 4; 
    }

}

// Responsibility: Rendering images of squares 
class SquareUI {

    public void draw() {
        if (highResolutionMonitor) {
            // Render a high resolution image of a square
        } else {
            // Render a normal image of a square
        }
    }

    public void rotate(int degree) {
        // Rotate the iamge of the square clockwise to
        // the required degree and re-render 
    }

}
```

Now Square calculates the area and SquareUI handles the rendering.

- `calculateArea()` and `calculatePerimeter()` are related to the square calculation;
- `draw()` and `rotate()` is related to rendering;


Example 2:
```js
// Responsibility 1: Handle core student profile data
// Responsibility 2: Handle Database Operations 
class Student {

    private String studentId;
    private String address;

    public void save() {
        // Serialize object into a string representation 
        String objectStr = MyUtils.serialzieIntoAString(this);
        Connection connection = null; 
        Statement stmt = null; 

        // We are using MYSQL
        // What if I want to use another database?
        // This is why Tight Coupling is bad practices for prgramming 
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyDb", "root", "password");
            stmt = connection.createStatement();
            stmt.execute("INSERT INTO STUDENTS VALUES (" + objectStr + ")");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

}
```

Refactoring:
```js
/** After Refactoring **/ 
// Responsibility: Handle Database Operations  
public class StudentRepository {
    public void save(student Student) {
        // We are using MYSQL
        // What if I want to use another database?
        // This is why Tight Coupling is bad practices for prgramming 
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/MyDb", "root", "password");
            stmt = connection.createStatement();
            stmt.execute("INSERT INTO STUDENTS VALUES (" + student + ")");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}

// Responsibility: Handle core student profile data
class Student {

    private String studentId;
    private Date studentDOB;
    private String address;

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

}

student = new Student(...)
studentRepository = StudentRepository(...)

studentRepository.save(student)
```