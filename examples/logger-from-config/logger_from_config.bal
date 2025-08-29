import ballerina/log;

// Define specialized logger configurations for different purposes
log:Config auditConfig = {
    level: log:INFO,
    format: log:JSON_FORMAT,
    destinations: [{path: "./logs/audit.log"}],
    keyValues: {"component": "audit", "compliance": "SOX"}
};

log:Config metricsConfig = {
    level: log:DEBUG,
    format: log:LOGFMT,
    destinations: [{path: "./logs/metrics.log"}],
    keyValues: {"component": "metrics", "retention": "30days"}
};

function processAuditEvent(string action, string userId) returns error? {
    // Create audit logger from configuration
    log:Logger auditLogger = check log:fromConfig(auditConfig);

    // Audit logs automatically include the component and compliance context
    auditLogger.printInfo("User action recorded",
                        action = action,
                        userId = userId);
}

function recordMetrics(string metricName, decimal value, string unit) returns error? {
    // Create metrics logger from configuration
    log:Logger metricsLogger = check log:fromConfig(metricsConfig);

    // Add operation-specific context to metrics logger
    log:Logger operationLogger = check metricsLogger.withContext(operation = "performance_monitoring");

    operationLogger.printDebug("Recording performance metric");
    operationLogger.printInfo("Performance metric recorded",
                            metric = metricName,
                            value = value,
                            unit = unit);
}

public function main() returns error? {
    // Regular application logs using root logger
    log:printInfo("Application started", version = "1.2.0");

    // Use specialized loggers with unique configurations
    check processAuditEvent("login", "alice123");
    check processAuditEvent("file_access", "bob456");

    check recordMetrics("response_time", 245.5, "ms");
    check recordMetrics("memory_usage", 78.2, "percent");

    log:printInfo("Application processing completed");
}
