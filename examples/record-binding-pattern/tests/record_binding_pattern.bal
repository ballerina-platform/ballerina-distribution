import ballerina/test;

(any|error)[] outputs = [];
int counter = 0;

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    string outstr = "";
        foreach var str in s {
            outstr = outstr + str.toString();
        }
        outputs[counter] = outstr;
        counter += 1;
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    main();
    test:assertEquals(outputs[0], "My Name: Jack Smith My Age: 23 My Address: street=380 Lakewood Dr. city=Desoto state=TX zipcode=75115 Other Fields: occupation=Software Engineer");
    test:assertEquals(outputs[1], "Name: Jack Smith Age: 23 Address: street=380 Lakewood Dr. city=Desoto state=TX zipcode=75115");
    test:assertEquals(outputs[2], "City: Desoto State: TX State: TX Zip Code: 75115");
}
