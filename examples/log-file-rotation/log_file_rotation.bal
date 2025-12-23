import ballerina/log;
import ballerina/lang.runtime;

// Define audit logger configuration with SIZE_BASED rotation
final readonly & log:Config auditConfig = {
    level: log:INFO,
    format: log:JSON_FORMAT,
    destinations: [{
        'type: log:FILE,
        path: "./logs/audit.log",
        rotation: {
            policy: log:SIZE_BASED,
            maxFileSize: 512,  // 512 bytes for demo (use 10485760 = 10MB in production)
            maxBackupFiles: 10
        }
    }],
    keyValues: {"component": "audit", "compliance": "enabled"}
};

function demonstrateTimeBasedRotation() {
    // Root logger is configured in Config.toml with TIME_BASED rotation
    // Logs will be written to ./logs/app.log
    log:printInfo("Application started", version = "1.0.0");

    foreach int i in 1...15 {
        log:printInfo("Processing request",
            requestId = string `req${i}`,
            endpoint = "/api/users",
            responseTime = 125 + i);

        if i % 5 == 0 {
            // Sleep to demonstrate time-based rotation (5 second threshold)
            runtime:sleep(2);
        }
    }

    log:printInfo("Application processing completed");
}

function demonstrateSizeBasedRotation() returns error? {
    // Create audit logger from configuration with SIZE_BASED rotation
    log:Logger auditLogger = check log:fromConfig(auditConfig);

    // Generate logs to trigger size-based rotation (512 bytes threshold)
    // Each JSON log entry is approximately 250-300 bytes
    // With 512 byte threshold, each file holds about 2 entries before rotating
    foreach int i in 1...6 {
        auditLogger.printInfo("User authentication event",
            action = "login",
            timestamp = "2025-12-23T10:30:00Z",
            ipAddress = string `192.168.1.${100 + i}`,
            userId = string `user${i}`,
            sessionId = string `session-${i}`);

        // Delay to ensure rotations happen in different seconds
        // (rotation timestamp format is yyyyMMdd-HHmmss)
        if i % 2 == 0 {
            runtime:sleep(1.2);
        }
    }

    log:printInfo("Generated 6 audit log entries");
}

public function main() returns error? {
    log:printInfo("Starting log rotation demonstration");

    log:printInfo("Demonstrating TIME_BASED rotation using root logger from Config.toml");
    demonstrateTimeBasedRotation();

    log:printInfo("Demonstrating SIZE_BASED rotation using programmatic logger");
    check demonstrateSizeBasedRotation();

    log:printInfo("Log rotation demonstration complete. Check ./logs directory for rotated log files.");
}
