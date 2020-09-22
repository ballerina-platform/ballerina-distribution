import ballerina/test;

(any|error)[] outputs = [];
int counter = 0;

// This is the mock function that replaces the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    foreach var entry in s {
        outputs[counter] = entry;
        counter += 1;
    }
}

@test:Config {}
function testFunc() {
    // Invoke the main function.
    main();
    test:assertEquals(outputs[0], "Error returned:");
    test:assertEquals(outputs[1], "InvalidAccountID,");
    test:assertEquals(outputs[2], "Error returned:");
    test:assertEquals(outputs[3], "AccountNotFound,");
}
