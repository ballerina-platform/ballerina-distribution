import ballerina/test;

string[] outputs = [];

// This is the mock function that replaces the real function.
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
    test:assertEquals(outputs[0], "Error caught: InvalidAccountID, Account ID: -1");
    test:assertEquals(outputs[1], "Error caught: AccountNotFound, Account ID: 200");
    test:assertEquals(outputs[2], "Error caught during parsing: {ballerina/lang.int}NumberParsingError");
}
