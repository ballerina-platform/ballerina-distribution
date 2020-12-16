import ballerina/log;

public function main() {
    error e = error("something went wrong!");

    // There are two log levels (INFO, ERROR) and there is no user configuration to control which log level to print.
    // Users can pass any number of key/value pairs which needs to be displayed in the log message.
    log:print("info log");
    log:print("info log", id = 845315, name = "foo");
    log:print("info log", id = 845315,
              name = isolated function() returns string { return "foo";});
    log:printError("error log");
    log:printError("error log",
        id = isolated function() returns int { return 845315;}, name = "foo");
    log:printError("error log with cause", err = e, id = 845315, name = "foo");
}
