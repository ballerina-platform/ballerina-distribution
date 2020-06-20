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
    test:assertEquals(outputs[3], "\nInsert success, generated IDs are: 1 2 3\n");
    test:assertEquals(outputs[5], "affectedRowCount=1 lastInsertId= affectedRowCount=-3 lastInsertId= affectedRowCount=1 lastInsertId=");
    test:assertEquals(outputs[6], "Rollback transaction.");
    test:assertEquals(outputs[7], "\nData in Customers table:");
    test:assertEquals(outputs[8], "customerId=1 firstName=Peter lastName=Stuart registrationID=1 creditLimit=5000.75 country=USA");
    test:assertEquals(outputs[9], "customerId=2 firstName=Stephanie lastName=Mike registrationID=2 creditLimit=8000.0 country=USA");
    test:assertEquals(outputs[10], "customerId=3 firstName=Bill lastName=John registrationID=3 creditLimit=3000.25 country=USA");
    test:assertEquals(outputs[11], "\nSample executed successfully!");
}
