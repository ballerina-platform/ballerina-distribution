import ballerina/io;

public function main() returns error? {
    do {
        // If either `foo()` or `bar()` invocations returns an `error`,
        // the error will be returned from the `main` function and execution
        // of the `main` function ends.
        check foo();
        check bar();

        if !isOK() {
            // Fails explicitly with an `error`.
            fail error("not OK");

        }
    }
    // Failure with the respective error is caught by the `on fail` block.
    on fail var e {
        io:println(e.toString());
        return e;
    }

}

function foo() returns error? {
    io:println("OK");
}

function bar() returns error? {
    io:println("OK");
}

function isOK() returns boolean {
    // not OK.
    return false;

}
