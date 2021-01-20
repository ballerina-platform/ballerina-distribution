import ballerina/test;
import ballerina/time;

string[] outputs = [];

@test:Mock {
    moduleName : "ballerina/io",
    functionName : "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any|error... val) {
    outputs.push(val.reduce(function (any|error a, any|error b) returns string => a.toString() + b.toString(), "").toString());
}

@test:Mock {
    moduleName: "ballerina/time",
    functionName: "currentTime"
}
test:MockFunction mock_currentTime = new();

public function mockCurrentTime() returns time:Time {
    return checkpanic time:createTime(2020, 1, 1, 0, 0, 0, 0, "America/Panama");
}

@test:Config {}
function testFunc() {
    test:when(mock_printLn).call("mockPrint");
    test:when(mock_currentTime).call("mockCurrentTime");

    // Calling the main fuction with empty args array
    main();
    test:assertEquals(outputs[0], "Full name: John Doe");
    test:assertEquals(outputs[1], "First name: John");
    test:assertEquals(outputs[2], "[1,3,5,6]");
    test:assertEquals(outputs[3], "3.141592653589793");
    test:assertEquals(outputs[4], "{\"time\":1577854800000,\"zone\":{\"id\":\"America/Panama\",\"offset\":-18000}}");
    test:assertEquals(outputs[5], "Jane Doe");
}
