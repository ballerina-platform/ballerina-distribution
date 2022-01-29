import ballerina/io;

class MyClass {
    int i = 0;
}

public function main() {
    MyClass obj1 = new MyClass();
    MyClass obj2 = new MyClass();
    // `b1` will be true.
    boolean b1 = (obj1 === obj1);
    // `b2` will be false.
    boolean b2 = (obj1 === obj2);
    // `b3` will be true.
    boolean b3 = ([1, 2, 3] == [1, 2, 3]);
    // `b4` will be false.
    boolean b4 = ([1, 2, 3] === [1, 2, 3]);
    // `b5` will be true.
    boolean b5 = (-0.0 == +0.0);
    // `b6` will be false.
    boolean b6 = (-0.0 === +0.0);

    io:println(b1);
    io:println(b2);
    io:println(b3);
    io:println(b4);
    io:println(b5);
    io:println(b6);
}
