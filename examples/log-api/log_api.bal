import ballerina/log;

public function main() {
    // The Ballerina log API provides functions to log at four levels, which are
    // `DEBUG`, `ERROR`, `INFO`, and `WARN`. By default, all log messages are
    // logged to the console at the `INFO` level.
    // The log level can be configured via a Ballerina configuration file.
    log:printDebug("debug log");
    log:printError("error log");
    log:printInfo("info log");
    log:printWarn("warn log");
    // To set the global log level, place the entry given below in the Config.toml file:
    //
    // ```
    // [ballerina.log]
    // level = "[LOG_LEVEL]"
    // ```

    // Each module can also be assigned its own log level. To assign a
    // log level to a module, provide the following entry in the Config.toml file:
    //
    // ```
    // [[ballerina.log.modules]]
    // name = "[ORG_NAME]/[MODULE_NAME]"
    // level = "[LOG_LEVEL]"
    // ```

    // Users can pass any number of key/value pairs which needs to be displayed in the log message.
    // These can be of `anydata` type including int, string and boolean.
    log:printInfo("info log", id = 845315, name = "foo", successful = true);

    // Users can also pass key/value pairs where the values are function pointers.
    log:printInfo("info log", id = 845315,
              name = isolated function() returns string { return "foo";});
    log:printError("error log",
        id = isolated function() returns int { return 845315;}, name = "foo");

    // Users can also pass a key/value pair where the value is an error stack trace.
    f1();

    // Optionally, an error can be passed to the functions.
    error e = error("something went wrong!");
    log:printError("error log with cause", 'error = e, id = 845315,
        name = "foo");

    // To set the output format to JSON, place the entry given below in the `Config.toml` file.
    //
    // ```
    // [ballerina.log]
    // format = "json"
    // ```
}

function f1() {
    f2();
}

function f2() {
    f3();
}

function f3() {
    error e = error("bad sad");
    log:printError("error log", stackTrace = e.stackTrace().callStack,
     username = "Alex92", id = 845315);
}
