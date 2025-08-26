import ballerina/log;

function processUserRequest(string userId, string requestId) returns error? {
    // Get the root logger
    log:Logger rootLogger = log:root();

    // Create a child logger with request-specific context
    log:Logger requestLogger = check rootLogger.withContext(userId = userId, requestId = requestId);

    requestLogger.printInfo("Processing user request");

    // All logs from this logger will include the userId and requestId context
    requestLogger.printDebug("Validating user permissions");
    requestLogger.printInfo("User permissions validated successfully");

    requestLogger.printDebug("Fetching user data from database");
    requestLogger.printInfo("User data retrieved", recordCount = 5);

    // Create a nested logger with additional context for a specific operation
    log:Logger operationLogger = check requestLogger.withContext(operation = "dataTransformation");
    operationLogger.printInfo("Starting data transformation");
    operationLogger.printWarn("Using fallback transformation method", reason = "primary method unavailable");
    operationLogger.printInfo("Data transformation completed", duration = "250ms");

    requestLogger.printInfo("Request processing completed successfully");
}

public function main() returns error? {
    // Process multiple requests with different contexts
    check processUserRequest("alice123", "req-001");

    check processUserRequest("bob456", "req-002");
}
