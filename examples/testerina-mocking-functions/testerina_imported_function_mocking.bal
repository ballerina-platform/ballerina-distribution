// This is the example for mocking an imported function.
import ballerina/io;
import ballerina/math;
import ballerina/test;

// This is the global array to which the mock function will push elements.
(any|error)[] outputs = [];

@test:Mock {
    // This specifies a mock function that should replace the `io:println`
    // function. The mock function signature should match that of the real.
    moduleName: "ballerina/io",
    functionName: "println"
}
function mockIoPrintLn((any|error)... text) {

    // This line adds the value to an array instead printing it.
    outputs.push(text);
}

// The function makes a call to io:println which should be replaced
// with the mock function.
public function printMathConsts() {
   io:println("Value of PI : ", math:PI);
}

// This specifies the test function that tests `printMathConsts` function.
@test:Config {}
function testMathConsts() {
   printMathConsts();
   test:assertEquals(outputs[0].toString(), "Value of PI :  3.141592653589793");
}
