import ballerina/test;

(any|error)[] outputs = [];
int counter = 0;

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    string printString = "";
    foreach var val in s {
        printString += val.toString();
    }
    outputs[counter] = printString;
    counter += 1;
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    main();
    test:assertEquals(outputs[0], "Iterating a string array:- ");
    test:assertEquals(outputs[1], "Fruit: apple");
    test:assertEquals(outputs[2], "Fruit: banana");
    test:assertEquals(outputs[3], "Fruit: cherry");

    test:assertEquals(outputs[4], "\nIterating a map:- ");
    test:assertEquals(outputs[5], "Capital: Washington, D.C.");
    test:assertEquals(outputs[6], "Capital: Colombo");
    test:assertEquals(outputs[7], "Capital: London");
    test:assertEquals(outputs[8], "Country: USA, Capital: Washington, D.C.");
    test:assertEquals(outputs[9], "Country: Sri Lanka, Capital: Colombo");
    test:assertEquals(outputs[10], "Country: England, Capital: London");
    test:assertEquals(outputs[11], "\nIterating a JSON object:- ");
    test:assertEquals(outputs[12], "Key: name Value: apple");
    test:assertEquals(outputs[13], "Key: colors Value: red green");
    test:assertEquals(outputs[14], "Key: price Value: 5");
    test:assertEquals(outputs[15], "\nIterating a JSON array:- ");
    test:assertEquals(outputs[16], "Color: red");
    test:assertEquals(outputs[17], "Color: green");
    test:assertEquals(outputs[18], "\nIterating an XML:- ");
    test:assertEquals(outputs[19], "Book: <book><name>Sherlock Holmes</name><author>Sir Arthur Conan Doyle</author></book>");
    test:assertEquals(outputs[20], "Book: <book><name>Harry Potter</name><author>J.K. Rowling</author></book>");
    test:assertEquals(outputs[21], "\nIterating a table:- ");
    test:assertEquals(outputs[22], "Employee: id=1 name=John salary=300.5");
    test:assertEquals(outputs[23], "Employee: id=2 name=Bella salary=500.5");
    test:assertEquals(outputs[24], "Employee: id=3 name=Peter salary=750.0");
    test:assertEquals(outputs[25], "\nIterating a closed integer range:- ");
    test:assertEquals(outputs[26], "Summation from 1 to 10 is 55");
    test:assertEquals(outputs[27], "\nIterating a half open integer range:- ");
    test:assertEquals(outputs[28], "Summation from 1 to 10 (exclusive) is 45");
}
