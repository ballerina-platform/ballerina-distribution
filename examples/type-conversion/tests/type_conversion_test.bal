import ballerina/test;

(any|error)?[] outputs = [];

// This is the mock function that replaces the real function.
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
    test:assertEquals(outputs[0], "Employee to Person, name: ");
    test:assertEquals(outputs[1], "Jack Sparrow");
    test:assertEquals(outputs[2], "map<anydata> to Person, name: ");
    test:assertEquals(outputs[3], "Hector Barbossa");
    test:assertEquals(outputs[4], "Error occurred on conversion: ");
    test:assertEquals(outputs[5].toString(),
                      "message='map<anydata>' value cannot be converted to 'type-conversion:Person'");
    test:assertEquals(outputs[6], "int value: ");
    test:assertEquals(outputs[7], 45);
    test:assertEquals(outputs[8], "error: ");
    test:assertEquals(outputs[9].toString(), "message='string' value 'abc' cannot be converted to 'int'");
    test:assertEquals(outputs[10], "float value: ");
    test:assertEquals(outputs[11], 12.3);
    test:assertEquals(outputs[12], "decimal value: ");
    test:assertEquals(outputs[13], <decimal> 8);
}
