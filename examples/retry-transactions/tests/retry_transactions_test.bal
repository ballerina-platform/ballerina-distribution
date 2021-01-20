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
    error? output = main();
    test:assertExactEquals(outputs[0], "Transaction Info: ");
    test:assertExactEquals(outputs[2], "Commit handler executed.");
    test:assertExactEquals(outputs[3], "Transaction committed.");
    test:assertExactEquals(outputs[4], "Account Credit: ");
    test:assertExactEquals(outputs[5], "{\"affectedRowCount\":1,\"lastInsertId\":null}");
    test:assertExactEquals(outputs[6], "Account Debit: ");
    test:assertExactEquals(outputs[7], "{\"affectedRowCount\":1,\"lastInsertId\":null}");
}
