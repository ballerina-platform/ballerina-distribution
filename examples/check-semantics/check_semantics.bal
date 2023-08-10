import ballerina/io;

public function main() returns error? {
    do {
        // If  `check` gets an error from either `foo()` or `bar()` invocations, the error will be caught at the `on fail`
        check foo();
        check bar();

        if !isOK() {
            // Fails explicitly with an error.
            fail error("not OK");

        }
    }
    // Failure with the respective error is caught by the `on fail` block.
    on fail var e {
        io:println(e.toString());
        return e;
    }

    return;
}

function foo() returns error? {
    io:println("OK");
    return;
}

function bar() returns error? {
    io:println("OK");
    return;
}

function isOK() returns boolean {
    // Returns `false`.
    return false;

}
