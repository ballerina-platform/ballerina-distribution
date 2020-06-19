import ballerina/test;

(any|error)[] outputs = [];

@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    foreach var entry in s {
        outputs.push(entry);
    }
}

@test:Config {}
function testFunc() {
    error? output = main();
    test:assertEquals(outputs[0], "start attempt 1:error, attempt 2:error, attempt 3:result returned end.");
}
