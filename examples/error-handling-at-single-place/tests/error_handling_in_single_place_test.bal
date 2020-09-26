import ballerina/test;

(any|error)[] outputs = [];
int counter = 0;

// This is the mock function that replaces the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public isolated function mockPrint(any|error... s) {
    foreach var entry in s {
        outputs[counter] = entry;
        counter += 1;
    }
}

@test:Config {}
function testFunc() {
    // Invoke the main function.
    main();
    test:assertExactEquals(outputs[0], "Error caught: ");
    test:assertExactEquals(outputs[1], "InvalidAccountID");
    test:assertExactEquals(outputs[2], ", Account ID: ");
    test:assertExactEquals(outputs[3], -1);
    test:assertExactEquals(outputs[4], "Error caught: ");
    test:assertExactEquals(outputs[5], "AccountNotFound");
    test:assertExactEquals(outputs[6], ", Account ID: ");
    test:assertExactEquals(outputs[7], 200);
    test:assertExactEquals(outputs[8], "Error caught during parsing: ");
    test:assertExactEquals(outputs[9], "{ballerina/lang.int}NumberParsingError");
}
