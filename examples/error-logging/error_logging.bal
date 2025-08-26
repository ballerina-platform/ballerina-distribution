import ballerina/log;

function processOrder(int orderId) returns error? {
    if orderId <= 0 {
        return error("Invalid order ID", orderId = orderId);
    }
    // Simulate processing logic here
}

function connectToDatabase() returns error? {
    error dbError = error("Connection timeout");
    return error("Failed to connect to database", dbError, retryCount = 3);
}

public function main() {
    // Basic error logging
    error simpleError = error("Something went wrong");
    log:printError("Application encountered an error", simpleError);

    // Error logging with additional context
    error|() result1 = processOrder(-1);
    if result1 is error {
        log:printError("Order processing failed", result1,
                operation = "processOrder",
                timestamp = "2025-08-25T10:30:00Z");
    }

    // Error with causes and stack trace
    error|() result2 = connectToDatabase();
    if result2 is error {
        log:printError("Database operation failed", result2,
                serviceName = "OrderService",
                severity = "HIGH");
    }

    // Custom error with detailed information
    error customError = error("Validation failed",
                            'field = "email",
                            value = "invalid-email",
                            expectedFormat = "user@domain.com");
    log:printError("User input validation error", customError,
            userId = "user123",
            action = "registration");
}
