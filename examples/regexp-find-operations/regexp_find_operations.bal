import ballerina/io;
import ballerina/lang.regexp;

public function main() returns error? {
    string logContent = string `
        2024-09-19 10:02:01 WARN  [UserLogin] - Failed login attempt for user: johndoe
        2024-09-19 10:03:17 ERROR [Database] - Connection to database timed out
        2024-09-19 10:04:05 WARN  [RequestHandler] - Response time exceeded threshold for /api/v1/users
        2024-09-19 10:05:45 INFO  [Scheduler] - Scheduled task started: Data backup
        2024-09-19 10:06:10 ERROR [Scheduler] - Failed to start data backup: Permission denied
        2024-09-19 10:11:55 INFO  [Security] - Security scan completed, no issues found
        2024-09-19 10:12:30 ERROR [RequestHandler] - 404 Not Found: /api/v1/products`;

    // Regular expression to match error logs with three groups:
    // 1. Timestamp (e.g., 2024-09-19 10:03:17).
    // 2. Component (e.g., Database, Scheduler).
    // 3. Log message (e.g., Connection to database timed out).
    string:RegExp errorLogPattern = re `(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) ERROR \[(\w+)\]\s-\s(.*)`;

    // Retrieve the first error log from `logContent`.
    regexp:Span? firstErrorLog = errorLogPattern.find(logContent);
    if firstErrorLog == () {
        io:println("Failed to find a error log");
        return;
    }
    io:println("First error log: ", firstErrorLog.substring());

    // Retrieve all error logs from the `logContent`.
    regexp:Span[] allErrorLogs = errorLogPattern.findAll(logContent);
    io:println("\nAll error logs:");
    foreach regexp:Span errorLog in allErrorLogs {
        io:println(errorLog.substring());
    }

    // Retrieve groups (timestamp, component, message) from the first error log.
    regexp:Groups? firstErrorLogGroups = errorLogPattern.findGroups(logContent);
    if firstErrorLogGroups == () {
        io:println("Failed to find groups in first error log");
        return;
    }
    io:println("\nGroups within first error log:");
    check printGroupsWithinLog(firstErrorLogGroups);

    // Retrieve groups from all error logs.
    regexp:Groups[] allErrorLogGroups = errorLogPattern.findAllGroups(logContent);
    io:println("\nGroups in all error logs");
    foreach regexp:Groups logGroup in allErrorLogGroups {
        check printGroupsWithinLog(logGroup);
    }
}

function printGroupsWithinLog(regexp:Groups logGroup) returns error? {
    // The first element in the `logGroup` is the entire matched string.
    // The subsequent elements in `logGroup` represent the captured groups 
    // (timestamp, component, message).
    string timestamp = (check logGroup[1].ensureType(regexp:Span)).substring();
    string component = (check logGroup[2].ensureType(regexp:Span)).substring();
    string logMessage = (check logGroup[3].ensureType(regexp:Span)).substring();

    io:println("Timestamp: ", timestamp);
    io:println("Component: ", component);
    io:println("Message: ", logMessage);
}
