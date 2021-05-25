// This demonstrates different ways to mock functions.
import ballerina/test;
import ballerina/io;

// Creates a `MockFunction` for stubbing calls to
// the `intAdd` function of the same module.
@test:Mock { functionName: "intAdd" }
test:MockFunction intAddMockFn = new();

@test:Config {}
function testReturn() {
    // Stubs the calls to return a specific value.
    test:when(intAddMockFn).thenReturn(20);
    // Stubs the calls to return a specific value when
    // specific arguments are provided.
    test:when(intAddMockFn).withArguments(0, 0).thenReturn(-1);

    test:assertEquals(intAdd(10, 6), 20, msg = "function mocking failed");
    test:assertEquals(intAdd(0, 0), -1,
            msg = "function mocking with arguments failed");
}

// Creates a `MockFunction` that should replace the
// imported `io:println` function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction printlnMockFn = new();

int tally = 0;

// This has a function signature similar to the `io:println` function.
public function mockPrint(any|error... val) {
    tally = tally + 1;
}

@test:Config {}
function testCall() {
    // Stubs the calls to the `io:println` function
    // to invoke the `mockPrint` function instead.
    test:when(printlnMockFn).call("mockPrint");

    io:println("Testing 1");
    io:println("Testing 2");
    io:println("Testing 3");

    test:assertEquals(tally, 3);
}
