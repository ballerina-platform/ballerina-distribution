import ballerina/test;

string[] outputs = [];

// This is the mock function, which will replace the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any|error... val) {
    outputs.push(toString(val.reduce(function (any|error a, any|error b) returns string => toString(a) + toString(b), "")));
}

function toString(any|error val) returns string => val is error? val.toString() : val.toString();

@test:Config {}
function testFunc() {
    test:when(mock_printLn).call("mockPrint");

    // Invoke the main function.
    error? e = main();
    if (e is error) {
        test:assertFail("Main function failed with : " + e.toString());
    }

    boolean assert = false;
    if ((outputs[1] == "Worker 2 response: 35") && (outputs[2] == "Worker 1 response: 6")) {
       assert = true;
    } else if ((outputs[1] == "Worker 1 response: 6") && (outputs[2] == "Worker 2 response: 35")) {
        assert = true;
    }
    test:assertTrue(assert);
}
