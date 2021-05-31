import ballerina/log;
import ballerina/random;
import ballerina/time;

public function main() {
    // The Ballerina log API provides functions to log at four levels, which are
    // `DEBUG`, `ERROR`, `INFO`, and `WARN`.
    // You can pass key/value pairs where the values are function pointers.
    // These functions can return values, which change dynamically.
    // The following log prints the current UTC time as a key/value pair.
    log:printInfo("info log",
                  current_time = isolated function() returns string {
                      return time:utcToString(time:utcNow());});
    // The following log prints a random percentage as a key/value pair.
    log:printInfo("info log",
                   percentage = isolated function() returns float {
                       return random:createDecimal() * 100.0;});
}
