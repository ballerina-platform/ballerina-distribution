import ballerina/io;
import ballerina/lang.regexp;

public function main() {
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
    io:println(string `First error log: ${firstErrorLog.substring()}`);

    // Retrieving all error logs from the `logContent`.
    regexp:Span[] allErrorLogs = errorLogPattern.findAll(logContent);
    io:println("\n", "All error logs:");
    foreach regexp:Span errorLog in allErrorLogs {
        io:println(errorLog.substring());
    }

    // Retrieving groups (timestamp, component, message) from the first error log.
    regexp:Groups? firstErrorLogGroups = errorLogPattern.findGroups(logContent);
    if firstErrorLogGroups == () {
        io:println("Failed to find groups in first error log");
        return;
    }
    io:println("\n", "Groups within first error log:");
    printGroupsWithinLog(firstErrorLogGroups);

    // Retrieving groups from all error logs.
    regexp:Groups[] allErrorLogGroups = errorLogPattern.findAllGroups(logContent);
    io:println("\n", "Groups in all error logs");
    foreach regexp:Groups logGroup in allErrorLogGroups {
        printGroupsWithinLog(logGroup);
    }
}

function printGroupsWithinLog(regexp:Groups logGroup) {
    // The first element in the `logGroup` is the entire matched string.
    // The subsequent elements in `logGroup` represent the captured groups 
    // (timestamp, component, message).
    string timestamp = (<regexp:Span>logGroup[1]).substring();
    string component = (<regexp:Span>logGroup[2]).substring();
    string logMessage = (<regexp:Span>logGroup[3]).substring();

    io:println(string `Timestamp: ${timestamp}`);
    io:println(string `Component: ${component}`);
    io:println(string `Message: ${logMessage}`);
}
