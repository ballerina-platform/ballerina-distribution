import ballerina/log;

function processUserRequest(string userId, string requestId) returns error? {
    // Get the root logger
    log:Logger rootLogger = log:root();

    // Create a child logger with request-specific context
    log:Logger requestLogger = check rootLogger.withContext(userId = userId, requestId = requestId);

    // All logs from this logger will include the userId and requestId context
    requestLogger.printInfo("User permissions validated successfully");

    // Create a nested logger with additional context for a specific operation
    log:Logger operationLogger = check requestLogger.withContext(operation = "dataTransformation");
    operationLogger.printWarn("Using fallback transformation method", reason = "primary method unavailable");
    operationLogger.printInfo("Data transformation completed", duration = "250ms");
}

public function main() returns error? {
    // Process multiple requests with different contexts
    check processUserRequest("alice123", "req-001");

    check processUserRequest("bob456", "req-002");
}
