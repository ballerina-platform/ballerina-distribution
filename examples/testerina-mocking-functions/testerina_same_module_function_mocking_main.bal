// This is the main.bal file of the example for mocking a function
// from the module under test.
import ballerina/io;

// This function calls the `intAdd` function and returns the result.
public function addValues(int a, int b) returns int {
    io:println("Performing addition of integers");
    return intAdd(a, b);
}

// This function adds two integers and returns the result.
public function intAdd(int a, int b) returns int {
    io:println("I'm the original function!");
    return (a + b);
}
