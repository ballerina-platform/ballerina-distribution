import ballerina/io;

type Cloneable object {
    function clone() returns Cloneable;
};

// `Shape` object type extends the `Clonable` object type, like interface extends another interface
type Shape object {
    *Cloneable;
    
    function draw() returns string;
};

// Circle class implements `Shape`, like implementing an interface
class Circle {
    *Shape;

    int radius;

    function init(int radius) {
        self.radius = radius;
    }

    // Returning `Circle` is valid, since the `Circle` type becomes a subtype of `Cloneable` type
    // once it includes the `Cloneable` object type
    function clone() returns Circle {
        return new(self.radius);
    }

    function draw() returns string {
        return string `circle:${self.radius}`;
    }
}

public function main() {
    Circle circle = new Circle(5);
    Circle circleClone = circle.clone();
    
    // `circle` and `circleClone` have different memory location, but identical objects
    io:println(circle === circleClone);
    io:println(circle.draw());
    io:println(circleClone.draw());
}
