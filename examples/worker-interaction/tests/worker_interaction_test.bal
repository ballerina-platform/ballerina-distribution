import ballerina/test;

string[] outputs = [];

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public isolated function mockPrint(any|error... val) {
    outputs.push(val.reduce(function (any|error a, any|error b) returns string => a.toString() + b.toString(), "").toString());
}

@test:Config{}
function testFunc() returns error? {
    // Invoking the main function
    main();
    test:assertEquals(outputs[0], "[w2] Message from w1: 6");
    test:assertEquals(outputs[1], "[w1] Message from w2: 91");
    test:assertEquals(outputs[2], "[w3] Messages from w1: 6, 91");
}
