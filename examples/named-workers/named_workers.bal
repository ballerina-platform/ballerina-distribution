import ballerina/io;

public function main() {
    // Code before any named workers is executed before named workers start.
    io:println("Initializing");
    final string greeting = "Hello";

    // A function can declare named workers, which run concurrently with the function's default worker
    // and other named workers.
    worker A {
        // Variables declared before all named workers and function parameters are accessible in named workers.
        io:println(greeting + " from worker A");

    }

    worker B {
        io:println(greeting + " from worker B");
    }

    io:println(greeting + " from function worker");
}
