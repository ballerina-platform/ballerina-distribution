import ballerina/test;

string[] outputs = [];

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... val) {
    outputs.push(val.reduce(function (any|error a, any|error b) returns string => a.toString() + b.toString(), "").toString());
}

@test:Config {}
function testFunc() {
    // Invoking the main function.
    main();
    test:assertEquals(outputs[0], "r1: Mary");
    test:assertEquals(outputs[1], "r2: Colombo 03");
    test:assertEquals(outputs[2], "r3: error {ballerina/lang.map}KeyNotFound message=Key 'age' not found in JSON mapping");
    test:assertEquals(outputs[3], "r4: ");
    test:assertEquals(outputs[4], "r5: ");
}

