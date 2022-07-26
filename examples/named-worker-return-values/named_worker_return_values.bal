import ballerina/io;

function demo(string s) returns int|error {
    // Named workers have a return type, which defaults to nil if not specified.
    worker A returns int|error {
        // A return statement in a named worker terminates the worker, not the function.
        // Similarly, when `check` is used and the expression evaluates to an `error`,
        // the `error` value is returned terminating only the worker.
        int x = check int:fromString(s);
        return x + 1;
    }

    io:println("In function worker");

    // Waiting on a named worker will give its return value.
    int y = check wait A;

    return y + 1;
}

public function main() returns error? {
    int res = check demo("50");
    io:println(res);

    res = check demo("50m");
    io:println(res);
}
