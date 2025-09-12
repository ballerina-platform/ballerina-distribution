import ballerina/log;

public function main() {
    // Log messages at different levels
    log:printDebug("This is a debug message");
    log:printInfo("Application started successfully");
    log:printWarn("This is a warning message");
    log:printError("This is an error message");
}
