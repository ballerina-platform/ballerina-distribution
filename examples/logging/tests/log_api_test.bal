import ballerina/test;
import ballerina/log;

log:PrintableRawTemplate|string printDebug = "";
log:PrintableRawTemplate|string printError = "";
log:PrintableRawTemplate|string printInfo = "";
log:PrintableRawTemplate|string printWarn = "";

// This is the mock function, which will replace the real function.

@test:Mock {
    moduleName: "ballerina/log",
    functionName: "printDebug"
}
test:MockFunction mock_printDebug = new();

public function mockPrintDebug(string|log:PrintableRawTemplate msg, error? err = (),
error:StackFrame[]? stackTrace = (), *log:KeyValues keyValues) {
    printDebug = msg;
}

@test:Mock {
    moduleName: "ballerina/log",
    functionName: "printError"
}
test:MockFunction mock_printError = new();

public function mockPrintError(string|log:PrintableRawTemplate msg, error? err = (),
error:StackFrame[]? stackTrace = (), *log:KeyValues keyValues) {
    printError = msg;
}

@test:Mock {
    moduleName: "ballerina/log",
    functionName: "printInfo"
}
test:MockFunction mock_printInfo = new();

public function mockPrintInfo(string|log:PrintableRawTemplate msg, error? err = (),
error:StackFrame[]? stackTrace = (), *log:KeyValues keyValues) {
    printInfo = msg;
}

@test:Mock {
    moduleName: "ballerina/log",
    functionName: "printWarn"
}
test:MockFunction mock_printWarn = new();

public function mockPrintWarn(string|log:PrintableRawTemplate msg, error? err = (),
error:StackFrame[]? stackTrace = (), *log:KeyValues keyValues) {
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
    test:assertEquals(printDebug, "This is a debug message");
    test:assertEquals(printError, "This is an error message");
    test:assertEquals(printInfo, "Application started successfully");
    test:assertEquals(printWarn, "This is a warning message");
}
