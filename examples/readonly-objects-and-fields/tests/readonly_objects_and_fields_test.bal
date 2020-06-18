import ballerina/test;

(any|error)[] outputs = [];

@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    outputs.push(...s);
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    error? res = trap main();
    test:assertEquals(outputs[0], "details is immutable: ");
    test:assertEquals(outputs[1], true);
    test:assertEquals(outputs[2], "Default: 1122");
    test:assertEquals(outputs[3], "Main: 4246");
}
