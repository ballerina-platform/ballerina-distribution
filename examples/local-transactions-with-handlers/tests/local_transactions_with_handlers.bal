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
        outputs.push(entry.toString());
    }
}

@test:Config {}
function testFunc() {
    test:when(mock_printLn).call("mockPrint");

    // Invoking the main function
    main();
    test:assertExactEquals(outputs[0], "Transaction Info: ");
    test:assertExactEquals(outputs[2], "Invoke local participant function.");
    test:assertExactEquals(outputs[3], "Local participant error.");
    test:assertExactEquals(outputs[4], "Rollback handler #2 executed.");
    test:assertExactEquals(outputs[5], "Rollback handler #1 executed.");
}
