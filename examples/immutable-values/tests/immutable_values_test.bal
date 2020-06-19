import ballerina/test;

(any|error)[] outputs = [];

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    outputs.push(...s);
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    main();
    test:assertEquals(outputs[0], "student is immutable: ");
    test:assertEquals(outputs[1], true);
    test:assertEquals(outputs[2], "student.details is immutable: ");
    test:assertEquals(outputs[3], true);
    test:assertEquals(outputs[4], "student.marks is immutable: ");
    test:assertEquals(outputs[5], true);
    test:assertEquals(outputs[6], "m1 === m2: ");
    test:assertEquals(outputs[7], false);
    test:assertEquals(outputs[8], "m1 is immutable: ");
    test:assertEquals(outputs[9], false);
    test:assertEquals(outputs[10], "m2 is immutable: ");
    test:assertEquals(outputs[11], true);
    test:assertEquals(outputs[12], "Error occurred on update: ");
    test:assertEquals(outputs[13], "Invalid map insertion: modification not allowed on readonly value");
    test:assertEquals(outputs[14], "m2 === m3: ");
    test:assertEquals(outputs[15], true);
    test:assertEquals(outputs[16], "frozenVal is map<string>");
}
