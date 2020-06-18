import ballerina/test;

(any|error)[] outputs = [];
int counter = 0;

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    outputs[counter] = s[0];
    counter += 1;
}

@test:Config { }
function testFunc() {
    // Invoking the main function
    var ret = main();
    test:assertEquals(outputs.length(), 25);
    test:assertEquals(outputs[0], "Base64 URL encoded value: YWJjMTIzIT8kKiYoKSctPUB-");
    test:assertEquals(outputs[1], "Base64 URL decoded value: abc123!?$*&()'-=@~");
    test:assertEquals(outputs[1], "URI encoded value: data%3Dvalue");
    test:assertEquals(outputs[1], "data=value");
}
