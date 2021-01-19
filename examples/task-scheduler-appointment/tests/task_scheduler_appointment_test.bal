import ballerina/lang.runtime;
import ballerina/test;

(any|error)[] outputs = [];
int counter = 0;

// This is the mock function that replaces the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    outputs[counter] = s[0];
    counter += 1;
}

@test:Config{}
function testFunc() returns error? {
    // Invoke the main function.
    check main();
    runtime:sleep(12);
    any|error result = outputs[5];
    if (result is error) {
        test:assertFail("Test failed.");
    } else {
        test:assertEquals(result.toString(), "Appointment cancelled.");
    }
}
