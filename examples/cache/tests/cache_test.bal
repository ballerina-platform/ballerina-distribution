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

@test:Config{}
function testFunc() returns error? {
    // Invoking the main function
    error? output = main();
    test:assertEquals(outputs[0].toString(), "key1: value1");
    test:assertEquals(outputs[1].toString(), "keys: [\"key2\"]");
    test:assertEquals(outputs[2].toString(), "size: 1");
    test:assertEquals(outputs[3].toString(), "keys: []");
}
