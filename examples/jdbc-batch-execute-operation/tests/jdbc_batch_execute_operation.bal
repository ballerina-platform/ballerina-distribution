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
    test:assertEquals(outputs[0], "Drop table executed: affectedRowCount=0 lastInsertId=");
    test:assertEquals(outputs[1], "Create table executed: affectedRowCount=0 lastInsertId=");
    test:assertEquals(outputs[2], "\nInsert success, generated IDs are: 1 2 3\n");
    test:assertEquals(outputs[4], "affectedRowCount=1 lastInsertId= affectedRowCount=-3 lastInsertId= affectedRowCount=1 lastInsertId=");
    test:assertEquals(outputs[5], "Rollback transaction.");
    test:assertEquals(outputs[6], "\nData in Customers table:");
    test:assertEquals(outputs[7], "CUSTOMERID=1 FIRSTNAME=Peter LASTNAME=Stuart REGISTRATIONID=1 CREDITLIMIT=5000.75 COUNTRY=USA");
    test:assertEquals(outputs[8], "CUSTOMERID=2 FIRSTNAME=Stephanie LASTNAME=Mike REGISTRATIONID=2 CREDITLIMIT=8000.0 COUNTRY=USA");
    test:assertEquals(outputs[9], "CUSTOMERID=3 FIRSTNAME=Bill LASTNAME=John REGISTRATIONID=3 CREDITLIMIT=3000.25 COUNTRY=USA");
    test:assertEquals(outputs[10], "\nSample executed successfully!");
}
