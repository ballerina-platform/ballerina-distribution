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

@test:Config {}
function testFunc() {
    // Invoke the main function.
    main();
    boolean assert = false;
    if ((outputs[1] == "Worker 2 response: 35") && (outputs[2] == "Worker 1 response: 6")) {
       assert = true;
    } else if ((outputs[1] == "Worker 1 response: 6") && (outputs[2] == "Worker 2 response: 35")) {
        assert = true;
    }
    test:assertTrue(assert);
}
