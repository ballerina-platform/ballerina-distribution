import ballerina/runtime;
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
function testFunc() {
    // Invoke the main function.
    main();
    runtime:sleep(12000);
    test:assertEquals(outputs[5].toString(), "Appointment cancelled.");
}
