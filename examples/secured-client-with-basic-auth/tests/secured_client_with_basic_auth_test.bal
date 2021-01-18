import ballerina/test;

string log = "";

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/log",
    functionName: "printInfo"
}
test:MockFunction mock_printInfo = new();

public function mockPrintInfo(anydata|(function () returns (anydata)) msg) {
    if (msg is string) {
        log = msg;
    }
}

@test:Config {}
function testFunc() {
    test:when(mock_printInfo).call("mockPrintInfo");
    // Invoking the main function
    main();
    test:assertEquals(log, "Hello, World!!!");
}
