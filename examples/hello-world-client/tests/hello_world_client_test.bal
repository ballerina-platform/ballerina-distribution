import ballerina/test;

(any|error)[] outputs = [];
int counter = 0;

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any|error... msg) {
    outputs[counter] = msg[0];
    counter += 1;
}

@test:Config {}
function testFunc() {
    test:when(mock_printLn).call("mockPrint");
    // Invoking the main function
    error? err = main();
    test:assertExactEquals(outputs[0], "Hello World");
}
