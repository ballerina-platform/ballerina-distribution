import ballerina/io;

public function main() {
    // Named workers, which run concurrently with the
    // function's default worker and other named workers.
    worker A {
        // It is safe to access the parameters of `sayHello` for the
        // duration of the function call.
        string a = sayHello("John");
        io:println(a);
    }

    worker B {
        string b = sayHello("Anne");
        io:println(b);
    }

    // `sayHello` is inferred to be an `isolated` function.
    boolean c = sayHello is isolated function (string str) returns string;
    io:println(c);
}

function sayHello(string name) returns string {
    return "Hello " + name;
}
