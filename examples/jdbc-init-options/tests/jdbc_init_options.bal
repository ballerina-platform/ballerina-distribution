import ballerina/test;

string[] outputs = [];
int counter = 0;

@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    outputs[counter] = s[0].toString();
    counter += 1;
}

@test:Config {}
function testFunc() {
    main();
    test:assertEquals(outputs[0], "Simple JDBC client created.");
    test:assertEquals(outputs[1], "JDBC client with user/password created.");
    test:assertEquals(outputs[2], "JDBC client with database options created.");
    test:assertEquals(outputs[3], "JDBC client with connection pool created.");
    test:assertEquals(outputs[4], "JDBC client with optional params created.");
    test:assertEquals(outputs[5], "Sample executed successfully!");
}
