import ballerina/test;

string[] outputs = [];

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any|error... val) {
    outputs.push(val.reduce(function (any|error a, any|error b) returns string => a.toString() + b.toString(), "").toString());
}

@test:Config {}
function testFunc() {
    test:when(mock_printLn).call("mockPrint");

    error? output = main();
    test:assertEquals(outputs[0], "Attempting execution...");
    test:assertEquals(outputs[1], "Attempting execution...");
    test:assertEquals(outputs[2], "Work completed.");
    test:assertEquals(outputs[3], "Attempting execution...");
    test:assertEquals(outputs[4], "Attempting execution...");
    test:assertEquals(outputs[5], "Work completed.");
}
