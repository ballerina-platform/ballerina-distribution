import ballerina/test;
import ballerina/log;

string printError = "";
string print = "";

// This is the mock function which will replace the real function

@test:Mock {
    moduleName: "ballerina/log",
    functionName: "printError"
}
public function mockPrintError(string msg, *log:ErrorKeyValues keyValues, error? err = ()) {
    printError = msg;
}

@test:Mock {
    moduleName: "ballerina/log",
    functionName: "print"
}
public function mockPrint(string msg, *log:KeyValues keyValues) {
    print = msg;
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    main();
    test:assertEquals(printError, "error log with cause");
    test:assertEquals(print, "info log");
}
