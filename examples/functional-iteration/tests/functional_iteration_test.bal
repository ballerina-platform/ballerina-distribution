import ballerina/test;

string[] outputs = [];

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... val) {
    outputs.push(val.reduce(function (any|error a, any|error b) returns string => a.toString() + b.toString(), "").toString());
}

@test:Config {}
function testFunc() {
    // Invoke the main function.
    main();
    test:assertEquals(outputs[0], "Number of elements in 'words': 5");
    test:assertEquals(outputs[1], "a=ANT b=BEAR c=CAT d=DEAR e=ELEPHANT");
    test:assertEquals(outputs[2], "-5");
    test:assertEquals(outputs[3], "-3");
    test:assertEquals(outputs[4], "2");
    test:assertEquals(outputs[5], "7");
    test:assertEquals(outputs[6], "12");
    test:assertEquals(outputs[7], "Positive numbers: 2 7 12");
    test:assertEquals(outputs[8], "Total: 13");
    test:assertEquals(outputs[9], "Student: Jack Grade: B");
    test:assertEquals(outputs[10], "Student: Tom Grade: D");
    test:assertEquals(outputs[11], "Student: Anne Grade: A");
}
