import ballerina/io;

public function main() {
    // `start` calls a function asynchronously.
    future<int> fut = start foo();

    // `wait` for `future<T>` gives `T|error`.
    int|error x = wait fut;

    io:println(x);
}

function foo() returns int {
    return 10;
}
