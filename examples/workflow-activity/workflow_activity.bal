import ballerina/io;
import ballerina/log;
import ballerina/workflow;

// An activity does the real work, such as calling an API or a database.
// The runtime records its result, so a completed activity does not run
// again when the workflow recovers.
@workflow:Activity
function sendEmail(string to) returns string|error {
    log:printInfo("Sending email", to = to);
    return "SENT";
}

@workflow:Workflow
function notify(workflow:Context ctx, string email) returns string|error {
    // Call an activity through the context, never directly. The arguments
    // are passed as a map keyed by the parameter names.
    string status = check ctx->callActivity(sendEmail, {"to": email});
    return status;
}

public function main() returns error? {
    string id = check workflow:run(notify, "alice@example.com");
    string status = check workflow:waitForResult(id);
    io:println("Email status: ", status);
}
