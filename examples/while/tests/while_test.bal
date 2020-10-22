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

string[] inputs = ["10b", "15", "Jack", "19", "Jane", "q"];

@test:Mock {
    moduleName: "ballerina/io",
    functionName: "readln"
}
public isolated function mockReadln(any prompt) returns string {
    return inputs.shift();
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    main();
    test:assertEquals(outputs[0], "0");
    test:assertEquals(outputs[1], "1");
    test:assertEquals(outputs[2], "2");
    test:assertEquals(outputs[3], "Invalid value, try again.");
    test:assertEquals(outputs[4], "Jack cannot vote!");
    test:assertEquals(outputs[5], "Jane can vote!");
}
