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
    // Invoking the main function
    main();
    test:assertEquals(outputs[0], "Process Add 1, 2: 3");
    test:assertEquals(outputs[1], "Process Multiply 3, 4: 12");
}
