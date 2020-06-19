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
    test:assertEquals(outputs[0], "empTwo is immutable: ");
    test:assertEquals(outputs[1], false);
    test:assertEquals(outputs[2], "details is immutable: ");
    test:assertEquals(outputs[3], true);
    test:assertEquals(outputs[4], "identifier is immutable: ");
    test:assertEquals(outputs[5], true);
    test:assertTrue(res is error);
    error err = <error> res;
    test:assertEquals(err.message(), "{ballerina/lang.map}InherentTypeViolation");
    string message = <string> err.detail()["message"];
    test:assertTrue(message.startsWith("cannot update 'readonly' field 'details' in record of type"));
    test:assertTrue(message.endsWith("Employee'"));
}
