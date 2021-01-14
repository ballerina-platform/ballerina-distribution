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

string[] inputs = ["Antarctica"];

@test:Mock {
    moduleName: "ballerina/io",
    functionName: "readln"
}
test:MockFunction mock_ReadLn = new();

public function mockReadln(any prompt) returns string {
    return inputs.shift();
}

@test:Config {}
function testFunc() {
    test:when(mock_printLn).call("mockPrint");
    test:when(mock_ReadLn).call("mockReadln");
    // Invoking the main function
    main();
    test:assertEquals(outputs[0], "The continent Antarctica does not have any countries");
}
