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
    // Invoke the main function.
    main();
    test:assertEquals(outputs[0], "Result: w1=6 w2=36");
}
