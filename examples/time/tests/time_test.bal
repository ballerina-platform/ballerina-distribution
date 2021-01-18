import ballerina/test;

(anydata|error)[] outputs = [];
int counter = 0;

// This is the mock function, which will replace the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any|error... s) {
    string outstr = "";
        foreach var str in s {
            outstr = outstr + str.toString();
        }
        outputs[counter] = outstr;
        counter += 1;
}

@test:Config {}
function testFunc() returns error? {
    test:when(mock_printLn).call("mockPrint");

    // Invoking the main function
    check main();
    test:assertEquals(outputs[1], "Created Time: 2017-03-28T23:42:45.554-05:00");
    test:assertEquals(outputs[2], "Parsed Time: 2017-06-26T09:46:22.444-05:00");
    test:assertEquals(outputs[16], "Before converting the time zone: 2017-03-28T23:42:45.554-05:00");
    test:assertEquals(outputs[17], "After converting the time zone: 2017-03-29T10:12:45.554+05:30");
    test:assertEquals(outputs[18], "Difference between the two time values: {"years":1,"months":2,"days":1,"hours":1,"minutes":0,"seconds":0,"milliSeconds":0}");
}
