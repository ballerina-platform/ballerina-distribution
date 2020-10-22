import ballerina/test;

string[] outputs = [];

// This is the mock function, which will replace the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public isolated function mockPrint(any|error... val) {
    outputs.push(val.reduce(function (any|error a, any|error b) returns string => a.toString() + b.toString(), "").toString());
}

@test:Config{}
function testFunc() {
    // Invoke the main function.
    main();
    test:assertEquals(outputs[0], "Seconds in an year = 31536000");
    test:assertEquals(outputs[1], "125*34 = 4250");
    test:assertEquals(outputs[2], "9! = 362880");
}
