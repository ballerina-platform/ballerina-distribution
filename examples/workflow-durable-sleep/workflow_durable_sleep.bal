import ballerina/io;
import ballerina/workflow;

@workflow:Activity
function sendReminder(string text) returns string|error {
    io:println("Sending reminder: ", text);
    return "REMINDED";
}

@workflow:Workflow
function remind(workflow:Context ctx, string text) returns string|error {
    // Pause durably. The timer is recorded by the runtime, so it survives a
    // restart and does not start again from the beginning. Use days or hours
    // in real workflows.
    check ctx.sleep({seconds: 5});
    return ctx->callActivity(sendReminder, {text});
}

public function main() returns error? {
    string id = check workflow:run(remind, "Renew your subscription");
    string status = check workflow:waitForResult(id);
    io:println("Reminder status: ", status);
}
