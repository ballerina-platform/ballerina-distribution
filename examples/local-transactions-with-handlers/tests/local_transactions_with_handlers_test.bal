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
    test:assertEquals(outputs[1], "Invoke local participant function.");
    test:assertEquals(outputs[2], "Local participant panicked.");
    test:assertEquals(outputs[3], "Rollback handler #2 executed.");
    test:assertEquals(outputs[4], "Rollback handler #1 executed.");
}
