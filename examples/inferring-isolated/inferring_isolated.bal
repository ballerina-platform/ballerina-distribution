import ballerina/io;

public function main() {
    // function's default worker, worker `A` and `B` run concurrently.
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
