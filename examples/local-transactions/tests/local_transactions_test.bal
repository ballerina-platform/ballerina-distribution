import ballerina/test;

(any|error)[] outputs = [];

@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    foreach var entry in s {
        outputs.push(entry);
    }
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    error? output = main();
    test:assertEquals(outputs[0], "Create CUSTOMER table status: ");
    test:assertEquals(outputs[1], 0);
    test:assertEquals(outputs[2], "Create SALARY table status: ");
    test:assertEquals(outputs[3], 0);
    test:assertEquals(outputs[5], "Transaction committed.");
    test:assertEquals(outputs[7], "Insert data into CUSTOMER table status: ");
    test:assertEquals(outputs[8], 1);
    test:assertEquals(outputs[9], "Insert data into SALARY table status: ");
    test:assertEquals(outputs[10], 1);
    test:assertEquals(outputs[11], "Drop table WITHDRAWALS status: ");
    test:assertEquals(outputs[12], 0);
    test:assertEquals(outputs[13], "Drop table DEPOSITS status: ");
    test:sertEquals(outputs[14], 0);
}
