import ballerina/test;
import ballerina/log;

string printError = "";
string print = "";

// This is the mock function, which will replace the real function.

@test:Mock {
    moduleName: "ballerina/log",
    functionName: "printError"
}
test:MockFunction mock_printError = new();

public function mockPrintError(string msg, *log:ErrorKeyValues keyValues, error? err = ()) {
    printError = msg;
}

@test:Mock {
    moduleName: "ballerina/log",
    functionName: "print"
}
test:MockFunction mock_print = new();

public function mockPrint(string msg, *log:KeyValues keyValues) {
    print = msg;
}

@test:Config {}
function testFunc() {
    test:when(mock_printLn).call("mockPrintError");
    test:when(mock_printLn).call("mockPrint");

    // Invoking the main function.
    main();
    test:assertEquals(printError, "error log with cause");
    test:assertEquals(print, "info log");
}
