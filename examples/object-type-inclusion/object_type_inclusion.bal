import ballerina/io;

type Cloneable object {
    function clone() returns Cloneable;
};

type Shape object {
    // The `Cloneable` object type is included as a part of the interface of 
    // the `Shape` object type.
    *Cloneable;

    // `draw()` is a part of `Shape`'s own type. 
    // The `clone()` function is also included from the `Cloneable` type.
    function draw() returns string;
};

class Circle {
    // The `Circle` class includes the `Shape` object type.
    // Therefore, it has to implement both the `clone()` and `draw()` methods.
    *Shape;

    int radius;

    function init(int radius) {
        self.radius = radius;
    }

    // Returning `Circle` is valid as the `Circle` type becomes a subtype of the `Cloneable` type
    // once it includes the `Cloneable` object type.
    function clone() returns Circle {
        return new(self.radius);
    }

    function draw() returns string {
        return string `circle:${self.radius}`;
    }
}

public function main() {
    Circle circle = new Circle(5);
    io:println(circle.draw());

    Circle circleClone = circle.clone();
    io:println(circleClone.draw());

    io:println(circle === circleClone);
}
