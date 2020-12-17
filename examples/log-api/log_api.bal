import ballerina/log;

public function main() {
    error e = error("something went wrong!");

    // There are two log levels (INFO, ERROR) and there is no user configuration to control which log level to print.
    log:print("info log");
    log:printError("error log");

    // Users can pass any number of key/value pairs which needs to be displayed in the log message.
    // These can be of anydata type including int, string and boolean.
    log:print("info log", id = 845315, name = "foo", successful = true);

    // Users can also pass key/value pairs where the values are function pointers.
    log:print("info log", id = 845315,
              name = isolated function() returns string { return "foo";});
    log:printError("error log",
        id = isolated function() returns int { return 845315;}, name = "foo");

    // Optionally an error can be passed to the printError function.
    log:printError("error log with cause", err = e, id = 845315, name = "foo");
}
