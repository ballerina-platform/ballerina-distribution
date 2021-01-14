import ballerina/test;

string[] outputs = [];

// This is the mock function that replaces the real function.
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

    // Invoke the main function.
    main();
    test:assertEquals(outputs[0], "Error returned:InvalidAccountID");
    test:assertEquals(outputs[1], "Error returned:AccountNotFound");
}
