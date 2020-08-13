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
    test:assertEquals(outputs[0], "Transaction Info: ");
    test:assertEquals(outputs[2], "Commit handler executed.");
    test:assertEquals(outputs[3], "Transaction committed.");
    test:assertEquals(outputs[4], "Account Credit: ");
    test:assertEquals(outputs[5], "affectedRowCount=1 lastInsertId=");
    test:assertEquals(outputs[6], "Account Debit: ");
    test:assertEquals(outputs[7], "affectedRowCount=1 lastInsertId=");
}
