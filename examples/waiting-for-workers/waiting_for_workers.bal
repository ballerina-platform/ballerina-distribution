import ballerina/io;

public function main() {
    io:println("Initializing");

    worker A {
        io:println("In worker A");
    }

    io:println("In function worker");

    // A worker (function or named) can use `wait` to wait for a named worker.
    wait A;

    io:println("After wait A");
}
