import ballerina/io;

function demo() returns future<int> {
    worker A returns int {
        return 42;
    }

    // A reference to a named worker can be implicitly converted into a `future`.
    return A;
}

type FuncInt function () returns int;

function startInt(FuncInt f) returns future<int> {
    // `start` is sugar for calling a function with a named worker and returning the named worker as a `future`.
    return start f();
}

public function main() returns error? {
    future<int> a = demo();
    int b = check wait a;
    io:println(b);

    future<int> c = startInt(() => 100);
    int d = check wait c;
    io:println(d);
}
