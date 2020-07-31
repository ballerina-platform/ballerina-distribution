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
    test:assertEquals(outputs[0], "Error: ");
    test:assertEquals(outputs[1], "Simple error occurred");
    test:assertEquals(outputs[2], "Error: ");
    test:assertEquals(outputs[3], "Invalid account ID");
    test:assertEquals(outputs[4], ", Account ID: ");
    test:assertEquals(outputs[5], -1);
    test:assertEquals(outputs[6], "Caused by: ");
    test:assertEquals(outputs[7], "Invalid account ID");
}
