// This demonstrates different ways to mock functions.
import ballerina/test;
import ballerina/io;

// This creates an object for stubbing calls to `intAdd`
// which is written in the same module.
@test:Mock { functionName: "intAdd" }
test:MockFunction intAddMockFn = new();

@test:Config {}
function testReturn() {
    // This stubs the calls to `intAdd` function to return the specified value.
    test:when(intAddMockFn).thenReturn(20);

    // This stubs the calls to `intAdd` function to return the specified value
    // when the specified arguments are provided.
    test:when(intAddMockFn).withArguments(0, 0).thenReturn(-1);

    test:assertEquals(intAdd(10, 6), 20, msg = "function mocking failed");
    test:assertEquals(intAdd(0, 0), -1,
        msg = "function mocking with arguments failed");
}

// This specifies a mock function that should replace the
// imported function `println`.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction printlnMockFn = new();

int tally = 0;

// This is a function that can be called in place of the `io:println` function.
public function mockPrint(any|error... val) {
    tally = tally + 1;
}

@test:Config {}
function testCall() {
    // This stubs the calls to io:println function
    // to invoke the specified function.
    test:when(printlnMockFn).call("mockPrint");

    io:println("Testing 1");
    io:println("Testing 2");
    io:println("Testing 3");

    test:assertEquals(tally, 3);
}
