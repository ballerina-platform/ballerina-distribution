import ballerina/test;

string[] outputs = [];
int counter = 0;

@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    string output = "";
    foreach var str in s {
        output += str.toString();
    }
    outputs[counter] = output;
    counter += 1;
}

@test:Config {}
function testFunc() {
    main();
    test:assertEquals(outputs[1], "Rows affected: 1");
    test:assertEquals(outputs[2], "Generated Customer ID: 1");
    test:assertEquals(outputs[3], "Updated Row count: 1");
    test:assertEquals(outputs[4], "Deleted Row count: 1");
    test:assertEquals(outputs[5], "Sample executed successfully!");
}
