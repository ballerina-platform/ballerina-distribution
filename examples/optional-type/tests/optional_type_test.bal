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

string[] inputs = ["Antarctica"];

@test:Mock {
    moduleName: "ballerina/io",
    functionName: "readln"
}
public function mockReadln(any prompt) returns string {
    return inputs.shift();
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    main();
    test:assertEquals(outputs[0], "The continent Antarctica does not have any countries");
}
