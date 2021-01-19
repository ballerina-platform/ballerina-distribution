import ballerina/stringutils;
import ballerina/test;

string[] outputs = [];

// This is the mock function, which will replace the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any... val) {
    outputs.push(val.reduce(function (any a, any b) returns string => a.toString() + b.toString(), "").toString());
}

@test:Config { }
function testFunc() returns error? {
    test:when(mock_printLn).call("mockPrint");

    // Invoking the main function
    check main();
    test:assertEquals(outputs.length(), 4);
    test:assertTrue(stringutils:contains(<string>outputs[0], "Base64 URL encoded value: YWJjMTIzIT8kKiYoKSctPUB-"));
    test:assertTrue(stringutils:contains(<string>outputs[1], "Base64 URL decoded value: abc123!?$*&()'-=@~"));
    test:assertTrue(stringutils:contains(<string>outputs[2], "URI encoded value: data%3Dvalue"));
    test:assertTrue(stringutils:contains(<string>outputs[3], "URI decoded value: data=value"));
}
