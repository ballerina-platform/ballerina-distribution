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
    main();
    test:assertEquals(outputs[0], 5);
    test:assertEquals(outputs[1], "ballerina");
    test:assertEquals(outputs[2], <map<int>> {math: 80, physics: 85, chemistry: 75});
    test:assertTrue(outputs[3] is boolean);
    test:assertTrue(<boolean> outputs[3]);
}
