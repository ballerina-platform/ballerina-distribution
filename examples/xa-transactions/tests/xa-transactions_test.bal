import ballerina/test;

(any|error)[] outputs = [];

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    foreach var entry in s {
        outputs.push(entry.toString());
    }
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    error? output = main();
    int len = outputs.length();
    test:assertExactEquals(outputs[len-7], "Transaction Info: ");
    test:assertExactEquals(outputs[len-5], "Transaction committed");
    test:assertExactEquals(outputs[len-4], "Employee Updated: ");
    test:assertExactEquals(outputs[len-3], "{\"affectedRowCount\":1,\"lastInsertId\":null}");
    test:assertExactEquals(outputs[len-2], "Salary Updated: ");
    test:assertExactEquals(outputs[len-1], "{\"affectedRowCount\":1,\"lastInsertId\":null}");
}
