import ballerina/http;
import ballerina/io;
import ballerina/workflow;
// Importing this module serves the workflow management REST API. Enable
// it in the `Config.toml` file.
import ballerina/workflow.management.rest as _;

type Approval record {|
    boolean approved;
|};

@workflow:Activity
function placeOrder(string item) returns string|error {
    io:println("Placing an order for ", item);
    return "PLACED";
}

@workflow:Workflow
function orderWorkflow(workflow:Context ctx, string item) returns string|error {
    // Pause durably until a `manager` completes the task.
    Approval approval = check ctx->awaitHumanTask("approveOrder", {item},
            userRoles = "manager", title = "Approve the order");
    if !approval.approved {
        return "REJECTED";
    }
    return ctx->callActivity(placeOrder, {item});
}

service /orders on new http:Listener(9090) {

    // Starts a workflow instance for the order and returns its ID.
    resource function post .(@http:Payload string item) returns string|error {
        return workflow:run(orderWorkflow, item);
    }
}
