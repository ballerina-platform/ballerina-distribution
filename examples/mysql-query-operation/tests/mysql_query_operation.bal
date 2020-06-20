import ballerina/test;

string[] outputs = [];
int counter = 0;

@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    match counter {
        1|4|9 => {
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
    test:assertEquals(outputs[1], "Customer full details: customerId=1 FirstName=Peter LastName=Stuart RegistrationID=1 CreditLimit=5000.75 Country=USA");
    test:assertEquals(outputs[4], "Customer full details: customerId=2 FirstName=Dan LastName=Brown RegistrationID=2 CreditLimit=10000.0 Country=UK");
    test:assertEquals(outputs[9], "Total rows in customer table : 2");
    test:assertEquals(outputs[12], "customerId=1 firstName=Peter lastName=Stuart registrationId=1 creditLimit=5000.75 country=USA");
    test:assertEquals(outputs[13], "customerId=2 firstName=Dan lastName=Brown registrationId=2 creditLimit=10000.0 country=UK");
    test:assertEquals(outputs[15], "Queried the database successfully!");
}
