import ballerina/test;

(any|error)[] outputs = [];

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any|error... s) {
    foreach var entry in s {
        string str = entry is error ? entry.toString() : entry.toString();
        outputs.push(str);
    }
}

@test:Config {}
function testFunc() returns error? {
    test:when(mock_printLn).call("mockPrint");

    // Invoking the main function
    check main();
    test:assertExactEquals(outputs[0], "Transaction Info: ");
    test:assertExactEquals(outputs[2], "Invoke local participant function.");
    test:assertExactEquals(outputs[3], "Local participant error.");
    test:assertExactEquals(outputs[4], "Rollback handler #2 executed.");
    test:assertExactEquals(outputs[5], "Rollback handler #1 executed.");
}
