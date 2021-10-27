import ballerina/io;
import ballerina/test;

// Executed before the `testFunction` function.
function beforeFunc() {
    io:println("I'm the before function!");
}

// The Test function.
// The `before` and `after` attributes are used to define the functions
// that need to be executed before and after this test function.
@test:Config {
    before: beforeFunc,
    after: afterFunc
}
function testFunction() {
    io:println("I'm in test function!");
    test:assertTrue(true, msg = "Failed!");
}

// Executed after the `testFunction` function.
function afterFunc() {
    io:println("I'm the after function!");
}
