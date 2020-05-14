import ballerina/test;
import ballerina/io;

(any|error)[] outputs = [];
int counter = 0;

// This is the mock function that will replace the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    foreach var arg in s {
        outputs[counter] = arg;
        counter += 1;
    }
}

@test:Config {}
function testFunc() {
    // Invoking the main function.
    main();

    string op1 = "id=1 name=John salary=300.5 id=2 name=Bella salary=500.5 id=3 name=Peter salary=750.0";
    string op2 = "Total number of Employees: 3";
    string op3 = "New Employee: id=4 name=Max salary=900.0";
    string op4 = "Employee 1: id=1 name=John salary=300.5";
    string op5 = "Information of the removed Employee: id=2 name=Bella salary=500.5";
    string op6 = "Employee table keys: 1 3 4";
    string op7 = "Employee table to list: id=1 name=John salary=300.5 id=3 name=Peter salary=750.0 " +
    "id=4 name=Max salary=900.0";
    string op8 = "Employees with salary < 400.0: John";
    string op9 = "Person Table Information: id=1 name=John age=23 id=3 name=Peter age=23 id=4 name=Max age=23";
    string op10 = "Customer Table Information: id=13 fname=Dan lname=Bing id=23 fname=Hay lname=Kelsey";
    string op11 = "Student Table Information: id=44 fname=Meena lname=Kaur id=55 fname=Jay address=Palm Grove, NY";

    test:assertEquals(outputs[0], op1);
    test:assertEquals(outputs[1], op2);
    test:assertEquals(outputs[2], op3);
    test:assertEquals(outputs[3], op4);
    test:assertEquals(outputs[4], op5);
    test:assertEquals(outputs[5], op6);
    test:assertEquals(outputs[6], op7);
    test:assertEquals(outputs[7], op8);
    test:assertEquals(outputs[8], op9);
    test:assertEquals(outputs[9], op10);
    test:assertEquals(outputs[10], op11);
}
