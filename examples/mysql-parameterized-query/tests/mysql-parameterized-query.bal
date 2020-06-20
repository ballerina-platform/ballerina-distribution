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

@test:Config {
    enable: false
}
function testFunc() {
    main();
    test:assertEquals(outputs[3], "\nInsert success, generated Id: 1");
    test:assertEquals(outputs[4], "\nBatch Insert success, generated IDs are: 2 3 4");
    test:assertEquals(outputs[5], "\nData in Customers table:");
    test:assertEquals(outputs[6], "customerId=1 firstName=Camellia lastName=Johns registrationID=1 creditLimit=5000.75 country=USA");
    test:assertEquals(outputs[7], "customerId=2 firstName=Peter lastName=Stuart registrationID=2 creditLimit=5000.75 country=USA");
    test:assertEquals(outputs[8], "customerId=3 firstName=Stephanie lastName=Mike registrationID=3 creditLimit=8000.0 country=USA");
    test:assertEquals(outputs[9], "customerId=4 firstName=Bill lastName=John registrationID=4 creditLimit=3000.25 country=USA");
    test:assertEquals(outputs[10], "\nSample executed successfully!");
}
