import ballerina/test;

string[] outputs = [];
int counter = 0;

@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    match counter {
        0 => {
            outputs[counter] = s[0].toString() + s[1].toString();
        }
        _ => {
            outputs[counter] = s[0].toString();
        }
    }
    counter += 1;
}

@test:Config {
    enable: false
}
function testFunc() {
    main();
    test:assertEquals(outputs[0], "Error when initializing the MySQL client without any params. error error in sql connector configuration: Failed to initialize pool: Access denied for user ''@'localhost' (using password: NO) Caused by :Access denied for user ''@'localhost' (using password: NO)");
    test:assertEquals(outputs[1], "MySQL client with user and password created.");
    test:assertEquals(outputs[2], "MySQL client with user and password created with default host.");
    test:assertEquals(outputs[3], "MySQL client with host, user, password, database and port created.");
    test:assertEquals(outputs[4], "MySQL client with database options created.");
    test:assertEquals(outputs[5], "MySQL client with connection pool created.");
    test:assertEquals(outputs[6], "Sample executed successfully!");
}
