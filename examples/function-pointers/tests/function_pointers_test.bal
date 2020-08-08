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
    test:assertEquals(outputs[0], "Process Add 1, 2: ");
    test:assertEquals(outputs[1], 3);
    test:assertEquals(outputs[2], "Process Multiply 3, 4: ");
    test:assertEquals(outputs[3], 12);
}
