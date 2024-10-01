import ballerina/log;

public type User record {
    string name;
    int age;
};

public function main() {
    // The Ballerina log API provides functions to log at four levels, which are `DEBUG`, `ERROR`, `INFO`, and `WARN`.
    log:printDebug("debug log");
    log:printError("error log");
    log:printInfo("info log");
    log:printWarn("warn log");

    User user = {
         name: "Harry",
         age: 20
    };
    // You can pass any number of key/value pairs, which need to be displayed in the log message.
    // These can be of the `anydata` type including int, string, boolean, records, etc.
    log:printInfo("info log", id = 845315, name = "foo", successful = true, user = user);

    // Optionally, an error can be passed to the functions.
    error e = error("something went wrong!");
    log:printError("error log with cause", 'error = e, id = 845315,
        name = "foo");
}
