import ballerina/io;

class MyClass {
    int n;

    function init(int n) {
        self.n = n;
    }

    function func() {
        self.n += 1;
    }
}

public function main() {
    // Apply `new` operator to a class to get an object.
    MyClass x = new MyClass(1234);

    // Call method using `obj.foo(args)`.
    x.func();

    // Access field using `obj.x`.
    int n = x.n;

    io:println(n);
}
