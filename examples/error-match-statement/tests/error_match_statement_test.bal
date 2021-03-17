import ballerina/test;

string[] outputs = [];
int counter = 0;

// This is the mock function, which will replace the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mockPrintLn = new();

public function mockPrint(any... s) {
    string outstr = "";
    foreach var str in s {
        outstr = outstr + (str is string ? str : "");
    }
    outputs[counter] = outstr;
    counter += 1;
}

@test:Config {}
function testFunc() {
    test:when(mockPrintLn).call("mockPrint");
    // Invoking the main function.
    main();

    string out1 = "Matched a value with a tuple shape";
    string out2 = "Matched a value with a record shape";
    string out3 = "Matched an error value : message: Failed";
    string out4 = "Matched an error value : message: Fatal, rest detail: {\"fatal\":true}";
    string out5 = "Matched `InvalidError` id=33456";

    test:assertEquals(outputs[0], out1);
    test:assertEquals(outputs[1], out2);
    test:assertEquals(outputs[2], out3);
    test:assertEquals(outputs[3], out4);
    test:assertEquals(outputs[4], out5);
}
