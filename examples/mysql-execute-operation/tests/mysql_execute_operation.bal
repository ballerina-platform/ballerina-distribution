import ballerina/test;

string[] outputs = [];
int counter = 0;

@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    match counter {
        0|1|6 => {
            outputs[counter] = s[0].toString();
        }
        _ => {
            outputs[counter] = s[0].toString() + s[1].toString();
        }
    }
    counter += 1;
}

@test:Config {
    enable:false
}
function testFunc() {
    main();
    test:assertEquals(outputs[2], "Rows affected: 1");
    test:assertEquals(outputs[3], "Generated Customer ID: 1");
    test:assertEquals(outputs[4], "Updated Row count: 1");
    test:assertEquals(outputs[5], "Deleted Row count: 1");
    test:assertEquals(outputs[6], "Sample executed successfully!");
}
