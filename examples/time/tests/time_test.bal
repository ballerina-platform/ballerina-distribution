import ballerina/test;

string[] outputs = [];
int counter = 0;

// This is the mock function, which will replace the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any... s) {
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
    test:assertEquals(outputs[3], "UTC value: 1196676930 0.0");
    test:assertEquals(outputs[4], "UTC string representation: 2007-12-03T10:15:30Z");
    test:assertEquals(outputs[6], "Is valid date: true");
    test:assertEquals(outputs[7], "Day of week: 1");
    test:assertEquals(outputs[8], "Civil record: {\"timeAbbrev\":\"Z\",\"year\":2007,\"month\":12,\"day\":3,\"hour\":10,\"minute\":15,\"second\":30}");
    test:assertEquals(outputs[9], "UTC value of the civil record: 1618269650 0.52");
    test:assertEquals(outputs[10], "Converted civil value: {\"utcOffset\":{\"hours\":5,\"minutes\":30},\"timeAbbrev\":\"Asia/Colombo\",\"year\":2021,\"month\":4,\"day\":12,\"hour\":23,\"minute\":20,\"second\":50.52}");
    test:assertEquals(outputs[11], "Civil string representation: 2021-04-12T17:50:50.520Z");

}
