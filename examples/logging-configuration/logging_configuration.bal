import ballerina/log;

public function main() {
    // These log messages will be formatted and filtered according to Config.toml
    log:printDebug("Debug message - application initialization");
    log:printInfo("Application started", version = "1.0.0");
    log:printWarn("High memory usage detected", memoryUsage = "85%");
    log:printError("Failed to connect to external service", serviceName = "PaymentAPI", timeout = "30s");

    // Logs will include the root context configured in Config.toml
    log:printInfo("User session created", userId = "user123", sessionId = "sess-456");
}
