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
    test:assertEquals(outputs[0], "Error caught: ");
    test:assertEquals(outputs[1], "InvalidAccountID,");
    test:assertEquals(outputs[2], ", Account ID: ");
    test:assertEquals(outputs[3], ", -1");
    test:assertEquals(outputs[4], "Error caught: ");
    test:assertEquals(outputs[5], "AccountNotFound,");
    test:assertEquals(outputs[6], ", Account ID: ");
    test:assertEquals(outputs[7], ", 200");
    test:assertEquals(outputs[8], "Error caught during parsing: ");
    test:assertEquals(outputs[9], "{ballerina/lang.int}NumberParsingError");
}
