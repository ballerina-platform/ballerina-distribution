import ballerina/io;

public function main() returns error? {
    do {
        // If either foo() or bar() invocations returns an error,
        // error will be returned from main function and execution
        // of main function ends.
        check foo();
        check bar();
        if !isOK() {
            // explicitly fail with an error.
            fail error("not OK");
        }
    }
    // failure with the respective error is caught by `on fail` block.
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
    // not OK
    return false;
}
