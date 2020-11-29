import ballerina/test;

(any|error)[] outputs = [];

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    foreach var entry in s {
        outputs.push(entry.toString());
    }
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    error? output = main();
    test:assertExactEquals(outputs[0], "Transaction Info: ");
    test:assertExactEquals(outputs[2], "Transaction committed");
    test:assertExactEquals(outputs[3], "Account Credit: ");
    test:assertExactEquals(outputs[4], "{\"affectedRowCount\":1,\"lastInsertId\":null}");
    test:assertExactEquals(outputs[5], "Account Debit: ");
    test:assertExactEquals(outputs[6], "{\"affectedRowCount\":1,\"lastInsertId\":null}");
}
