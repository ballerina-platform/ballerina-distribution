import ballerina/test;

(any|error)?[] outputs = [];
int counter = 0;

// This is the mock function that replaces the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    foreach var elem in s {
        outputs[counter] = elem;
        counter += 1;
    }
}

@test:Config {}
function testFunc() {
    // Invoking the main function.
    main();
    test:assertEquals(outputs[0], "Is 'message' a string? ");
    test:assertEquals(outputs[1], true);
    test:assertEquals(outputs[2], "'message' is a string with value: ");
    test:assertEquals(outputs[3], "Hello, world!");
    test:assertEquals(outputs[4], "entity is a student");
    test:assertEquals(outputs[5], "entity is a person");
    test:assertEquals(outputs[6], "entity is not a vehicle");
    test:assertEquals(outputs[7], "Did createEntity(\"student\") return a student? ");
    test:assertEquals(outputs[8], true);
    test:assertEquals(outputs[9], "Did createEntity(\"vehicle\") return a student? ");
    test:assertEquals(outputs[10], false);
}
