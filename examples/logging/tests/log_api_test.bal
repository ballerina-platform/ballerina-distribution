import ballerina/test;
import ballerina/log;

string printDebug = "";
string printError = "";
string printInfo = "";
string printWarn = "";

// This is the mock function, which will replace the real function.

@test:Mock {
    moduleName: "ballerina/log",
    functionName: "printDebug"
}
test:MockFunction mock_printDebug = new();

public function mockPrintDebug(string msg, error? err = (), *log:KeyValues keyValues) {
    printDebug = msg;
}

@test:Mock {
    moduleName: "ballerina/log",
    functionName: "printError"
}
test:MockFunction mock_printError = new();

public function mockPrintError(string msg, error? err = (), *log:KeyValues keyValues) {
    printError = msg;
}

@test:Mock {
    moduleName: "ballerina/log",
    functionName: "printInfo"
}
test:MockFunction mock_printInfo = new();

public function mockPrintInfo(string msg, error? err = (), *log:KeyValues keyValues) {
    printInfo = msg;
}

@test:Mock {
    moduleName: "ballerina/log",
    functionName: "printWarn"
}
test:MockFunction mock_printWarn = new();

public function mockPrintWarn(string msg, error? err = (), *log:KeyValues keyValues) {
    printWarn = msg;
}

@test:Config {}
function testFunc() {
    test:when(mock_printDebug).call("mockPrintDebug");
    test:when(mock_printError).call("mockPrintError");
    test:when(mock_printInfo).call("mockPrintInfo");
    test:when(mock_printWarn).call("mockPrintWarn");

    // Invoking the main function.
    main();
    test:assertEquals(printDebug, "debug log");
    test:assertEquals(printError, "error log with cause");
    test:assertEquals(printInfo, "info log");
    test:assertEquals(printWarn, "warn log");
}
