// This demonstrates different ways to mock functions.
import ballerina/test;
import ballerina/math;

@test:Mock {
    // This specifies a mock function that should replace the
    // imported function `math:sqrt`.
    moduleName: "ballerina/math",
    functionName: "sqrt"
}
test:MockFunction sqrtMockFn = new();

// This is a mock function that can be called in place of `math:sqrt` function.
function mockSqrt(float val) returns float {
    return 125.0;
}

@test:Config {}
function testCall() {
   // This stubs the calls to `math:sqrt` function
   // to invoke the specified function.
   test:when(sqrtMockFn).call("mockSqrt");
   test:assertEquals(math:sqrt(25), 125.0);
}

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
