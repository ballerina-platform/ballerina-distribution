import ballerina/test;

(any|error)[] outputs = [];

// This is the mock function which will replace the real function
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
    main();
    test:assertEquals(outputs[0], "Name: ");
    test:assertEquals(outputs[1], "John Doe");
    test:assertEquals(outputs[2], "Name: John Doe");
    test:assertEquals(outputs[3], "Name: Bill Lambert");
}
