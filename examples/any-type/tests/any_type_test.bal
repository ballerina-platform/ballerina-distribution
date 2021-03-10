import ballerina/test;
import ballerina/time;

string[] outputs = [];

@test:Mock {
    moduleName : "ballerina/io",
    functionName : "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any|error... val) {
    outputs.push(toString(val.reduce(function (any|error a, any|error b) returns string => toString(a) + toString(b), "")));
}

function toString(any|error val) returns string => val is error? val.toString() : val.toString();

@test:Mock {
    moduleName: "ballerina/time",
    functionName: "utcNow"
}
test:MockFunction mock_utcNow = new();

public function mockUtcNow(int? p) returns time:Utc {
    return checkpanic time:utcFromString("2020-12-03T10:15:30.00Z");
}

@test:Config {}
function testFunc() {
    test:when(mock_printLn).call("mockPrint");
    test:when(mock_utcNow).call("mockUtcNow");

    // Calling the main fuction with empty args array
    main();
    test:assertEquals(outputs[0], "Full name: John Doe");
    test:assertEquals(outputs[1], "First name: John");
    test:assertEquals(outputs[2], "[1,3,5,6]");
    test:assertEquals(outputs[3], "3.141592653589793");
    test:assertEquals(outputs[4], "2020-12-03T10:15:30Z");
    test:assertEquals(outputs[5], "Jane Doe");
}
