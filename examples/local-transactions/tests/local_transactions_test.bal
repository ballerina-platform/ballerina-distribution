import ballerina/test;

(any|error)[] outputs = [];

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
    test:assertEquals(outputs[2], "Transaction committed");
    test:assertEquals(outputs[3], "Account Credit: ");
    test:assertEquals(outputs[4], "affectedRowCount=1 lastInsertId=");
    test:assertEquals(outputs[5], "Account Debit: ");
    test:assertEquals(outputs[6], "affectedRowCount=1 lastInsertId=");
}
