// This is the main_test.bal file of the example for mocking a function
// from the module under test.
import ballerina/io;
import ballerina/test;

// This creates an object for stubbing calls to `intAdd`.
@test:MockFn { functionName: "intAdd" }
// This object will be used to stub the calls to `intAdd` function.
test:MockFunction intAddMockFn = new();

@test:Config {}
function testAssertIntEquals1() {
    // This stubs the calls to `intAdd` function to return the specified value.
    test:when(intAddMockFn).thenReturn(20);
    test:assertEquals(intAdd(10, 6), 20, msg = "function mocking failed");
}

@test:Config {}
function testAssertIntEquals2() {
    // This stubs the calls to `intAdd` function to return the specified value.
    test:when(intAddMockFn).thenReturn(20);

    // This stubs the calls to `intAdd` function to return the specified value
    // if the specified arguments are provided.
    test:when(intAddMockFn).withArguments(0, 0).thenReturn(-1);

    // This should return `20`.
    test:assertEquals(intAdd(10, 6), 20, msg = "function mocking failed");
    
    // This should return `-1`.
    test:assertEquals(intAdd(0, 0), -1,
        msg = "function mocking with arguments failed");

}

// This is the mock function that should be called
// in place of `intAdd` function. The mock function
// signature should match the `intAdd` function.
public function mockIntAdd(int a, int b) returns int {
    io:println("I'm the mock function!");
    return (a - b);
}

@test:Config {}
function testAssertIntEquals3() {
    // This stubs the calls to `intAdd` function to invoke the
    // created mock function.
    test:when(intAddMockFn).call("mockIntAdd");

    // This verifies that the mock function is called in place of the real.
    test:assertEquals(addValues(10, 6), 4, msg = "function mocking failed");

}
