import ballerina/log;
import ballerina/lang.runtime;

public function main() {
    // Root logger is configured in Config.toml with TIME_BASED rotation
    // Logs will be written to ./logs/app.log
    log:printInfo("Starting log rotation demonstration");
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
    log:printInfo("Log rotation demonstration complete. Check ./logs directory for rotated log files.");
}
